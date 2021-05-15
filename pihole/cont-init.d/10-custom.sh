#!/usr/bin/with-contenv bash
set -e

# openFleets: configure hostname
curl -X PATCH --header "Content-Type:application/json" \
   --data "{\"network\": {\"hostname\": \"$BALENA_HOSTNAME\"}}" \
   "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY"

while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done
