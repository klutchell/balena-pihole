#!/usr/bin/env bash

set -e

# avoid port conflicts with resin-dns
# https://docs.pi-hole.net/ftldns/interfaces/
mkdir -p /etc/dnsmasq.d
echo "bind-interfaces" >/etc/dnsmasq.d/90-resin-dns.conf
echo "except-interface=resin-dns" >>/etc/dnsmasq.d/90-resin-dns.conf
# remove deprecated dnsmasq config files if they exist
rm -f /etc/dnsmasq.d/balena.conf /etc/dnsmasq.d/01-pihole.conf

# source bash functions like setFTLConfigValue
# shellcheck source=/dev/null
# . /usr/bin/bash_functions.sh

# enable inclusion of dnsmasq.d conf files
# https://github.com/pi-hole/FTL/pull/1734
pihole-FTL --config misc.etc_dnsmasq_d true

# update the webpassword if one was provided
pihole setpassword "${WEBPASSWORD:-}" || true

# check if we are using unbound as upstream DNS
if [[ ${PIHOLE_DNS_%;*} =~ ^127\.0\.0\.1#5053$ ]]; then
   # https://docs.pi-hole.net/guides/dns/unbound/
   # https://docs.pi-hole.net/ftldns/dnsmasq_warn/#reducing-dns-packet-size-for-nameserver-address-to-safe_pktsz
   pkt_size=1232
   echo "Reducing DNS packet size for nameserver ${PIHOLE_DNS_%;*} to ${pkt_size}..."
   echo "edns-packet-max=${pkt_size}" >/etc/dnsmasq.d/99-edns.conf
fi

# execute the Pi-hole entrypoint in the background
/usr/bin/start.sh &
pid=$!

# quit the plymouth (balena logo) service so that we can see the TTY
echo "Stopping plymouth service..."
dbus-send \
   --system \
   --dest=org.freedesktop.systemd1 \
   --type=method_call \
   --print-reply \
   /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager.StartUnit \
   string:"plymouth-quit.service" string:"replace"

# get the FTL webserver port
webserver_port="$(pihole-FTL --config webserver.port)"
webserver_port="${webserver_port%%,*}"

is_api_available() {
   response="$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${webserver_port}/api/auth")"
   case "${response}" in
   200 | 401) return 0 ;;
   *) return 1 ;;
   esac
}

# wait for FTL API to be available
while ! is_api_available; do
   sleep 2
done

console=/dev/tty1

# check if console is available
if [ -e "${console}" ]; then
   # https://wiki.alpinelinux.org/wiki/Fonts
   # https://www.man7.org/linux/man-pages/man8/setfont.8.html
   echo "Setting console font to ${CONSOLE_FONT}..."
   setfont -C "${console}" /usr/share/consolefonts/"${CONSOLE_FONT}".psf.gz

   # calculate the size of the target tty rather than the current terminal session
   console_height="$(stty size -F "${console}" | awk '{print $1}')"
   console_width="$(stty size -F "${console}" | awk '{print $2}')"

   sed "s|console_height=.*|console_height=$console_height|" -i /usr/local/bin/padd
   sed "s|console_width=.*|console_width=$console_width|" -i /usr/local/bin/padd

   # start PADD as a background process
   echo "Starting PADD..."
   /usr/local/bin/padd --secret "${WEBPASSWORD:-}" 2>/dev/null >"${console}" &
fi

# reattach to the Pi-hole entrypoint process
wait $pid
