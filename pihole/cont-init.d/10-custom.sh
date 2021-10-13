#!/usr/bin/with-contenv bash
# shellcheck shell=bash

set -e

while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "Waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done

pihole -a -p "${WEBPASSWORD}" || true

echo "127.0.0.1 pihole" >> /etc/hosts
echo "127.0.0.1 $(hostname)" >> /etc/hosts

# https://serverfault.com/a/817791
# force dnsmasq to bind only the interfaces it is listening on
# otherwise dnsmasq will fail to start since balena is using 53 on some interfaces
echo "bind-interfaces" > /etc/dnsmasq.d/balena.conf
