#!/command/with-contenv bash
# shellcheck shell=bash

set -e

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

while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "Waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done
