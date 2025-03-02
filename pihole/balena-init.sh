#!/usr/bin/env bash

set -e

# Use EDNS_PACKET_MAX=1232 to avoid unbound DNS packet size warnings
# https://docs.pi-hole.net/guides/dns/unbound/
# https://docs.pi-hole.net/ftldns/dnsmasq_warn/#reducing-dns-packet-size-for-nameserver-address-to-safe_pktsz
if [[ ${EDNS_PACKET_MAX:-} =~ [0-9]+$ ]]; then
   echo "Reducing DNS packet size to ${EDNS_PACKET_MAX}..."
   echo "edns-packet-max=${EDNS_PACKET_MAX}" >/etc/dnsmasq.d/99-edns.conf
fi

# execute the Pi-hole entrypoint
exec /usr/bin/start.sh
