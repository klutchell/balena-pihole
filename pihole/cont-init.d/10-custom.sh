#!/usr/bin/with-contenv bash
set -e

# set a hostname for mDNS (default to pihole.local)
if [ -n "${SET_HOSTNAME}" ]
then
   curl -X PATCH --header "Content-Type:application/json" \
      --data "{\"network\": {\"hostname\": \"${SET_HOSTNAME}\"}}" \
      "${BALENA_SUPERVISOR_ADDRESS}/v1/device/host-config?apikey=${BALENA_SUPERVISOR_API_KEY}" || true
fi

while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done
