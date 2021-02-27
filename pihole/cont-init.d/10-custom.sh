#!/usr/bin/with-contenv bash
set -e

while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done
