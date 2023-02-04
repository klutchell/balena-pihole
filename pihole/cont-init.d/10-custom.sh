#!/command/with-contenv bash
# shellcheck shell=bash

set -e

# avoid port conflicts with resin-dns
# https://docs.pi-hole.net/ftldns/interfaces/
# these steps must be at runtime because /etc/dnsmasq.d is a user volume
echo "bind-interfaces" > /etc/dnsmasq.d/90-resin-dns.conf
echo "except-interface=resin-dns" >> /etc/dnsmasq.d/90-resin-dns.conf

if [ -f /etc/dnsmasq.d/balena.conf ]
then
   # remove the old config file
   rm /etc/dnsmasq.d/balena.conf
fi

pihole -a -p "${WEBPASSWORD}" || true

# check if we are using unbound as upstream DNS
if [[ ${PIHOLE_DNS_%;*} =~ ^127\.0\.0\.1#5053$ ]]
then
   # https://docs.pi-hole.net/guides/dns/unbound/
   # https://docs.pi-hole.net/ftldns/dnsmasq_warn/#reducing-dns-packet-size-for-nameserver-address-to-safe_pktsz
   pkt_size=1232
   echo "Reducing DNS packet size for nameserver ${PIHOLE_DNS_%;*} to ${pkt_size}..."
   echo "edns-packet-max=${pkt_size}" > /etc/dnsmasq.d/99-edns.conf
fi
