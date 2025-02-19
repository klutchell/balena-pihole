#!/usr/bin/env bash

set -e

# avoid port conflicts with resin-dns
# https://docs.pi-hole.net/ftldns/interfaces/
mkdir -p /etc/dnsmasq.d
echo "bind-interfaces" >/etc/dnsmasq.d/90-resin-dns.conf
echo "except-interface=resin-dns" >>/etc/dnsmasq.d/90-resin-dns.conf
# remove deprecated dnsmasq config files if they exist
rm -f /etc/dnsmasq.d/balena.conf /etc/dnsmasq.d/01-pihole.conf

# Use EDNS_PACKET_MAX=1232 to avoid unbound DNS packet size warnings
# https://docs.pi-hole.net/guides/dns/unbound/
# https://docs.pi-hole.net/ftldns/dnsmasq_warn/#reducing-dns-packet-size-for-nameserver-address-to-safe_pktsz
if [[ ${EDNS_PACKET_MAX:-} =~ [0-9]+$ ]]; then
   echo "Reducing DNS packet size to ${EDNS_PACKET_MAX}..."
   echo "edns-packet-max=${EDNS_PACKET_MAX}" >/etc/dnsmasq.d/99-edns.conf
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
# shellcheck disable=SC2310
while ! is_api_available; do
   echo "Waiting for FTL API to be available..."
   sleep 5
done

console=/dev/tty1

# check if console is available
if [[ -e "${console}" ]] && [[ -n "${CONSOLE_FONT}" ]]; then
   # https://wiki.alpinelinux.org/wiki/Fonts
   # https://www.man7.org/linux/man-pages/man8/setfont.8.html
   echo "Setting console font to ${CONSOLE_FONT}..."
   setfont -C "${console}" /usr/share/consolefonts/"${CONSOLE_FONT}".psf.gz

   # calculate the size of the target tty rather than the current terminal session
   stty_size="$(stty size -F "${console}")"
   console_height="$(echo "${stty_size}" | awk '{print $1}')"
   console_width="$(echo "${stty_size}" | awk '{print $2}')"

   sed "s|console_height=.*|console_height=${console_height}|" -i /usr/local/bin/padd
   sed "s|console_width=.*|console_width=${console_width}|" -i /usr/local/bin/padd

   # start PADD as a background process
   echo "Starting PADD..."
   /usr/local/bin/padd 2>/dev/null >"${console}" &
fi

# reattach to the Pi-hole entrypoint process
wait "${pid}"
