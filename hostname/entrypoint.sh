#!/bin/sh
set -u

echo "--- Hostname ---"

if [ -z "${SET_HOSTNAME:-}" ]; then
    echo "SET_HOSTNAME not set, nothing to do."
    exit 0
fi

API="${BALENA_SUPERVISOR_ADDRESS}/v1/device/host-config"
AUTH="Authorization: Bearer ${BALENA_SUPERVISOR_API_KEY}"
CURL="curl -s --connect-timeout 10 --max-time 30"

CURRENT="$(${CURL} -H "${AUTH}" "${API}" | jq -r '.network.hostname // empty')"
if [ -z "${CURRENT}" ]; then
    echo "Warning: could not read current hostname from the supervisor."
fi
echo "Current hostname: ${CURRENT}"
echo "Target hostname:  ${SET_HOSTNAME}"

if [ "${CURRENT}" = "${SET_HOSTNAME}" ]; then
    echo "Hostname already set, nothing to do."
    exit 0
fi

# The supervisor serializes host-config changes against its own apply loop and
# returns 423 while one is in flight, so retry until it clears.
BODY="$(jq -n --arg h "${SET_HOSTNAME}" '{network:{hostname:$h},force:true}')"
for attempt in 1 2 3 4 5; do
    echo "Setting hostname (attempt ${attempt})..."
    HTTP_CODE="$(${CURL} -s -o /tmp/response -w '%{http_code}' -X PATCH "${API}" \
        -H "${AUTH}" \
        -H 'Content-Type: application/json' \
        -d "${BODY}")"
    if [ "${HTTP_CODE}" = "200" ]; then
        echo "Hostname updated, services will restart to pick it up."
        exit 0
    fi
    echo "Supervisor returned HTTP ${HTTP_CODE}: $(cat /tmp/response)"
    sleep 10
done

echo "Failed to set hostname after 5 attempts."
exit 1
