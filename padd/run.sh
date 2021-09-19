#!/usr/bin/env sh

set -e

# quit the plymouth (balena logo) service so that we can see the TTY
echo "Stopping plymouth service..."
dbus-send \
    --system \
    --dest=org.freedesktop.systemd1 \
    --type=method_call \
    --print-reply \
    /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager.StartUnit \
    string:"plymouth-quit.service" string:"replace"

FONTSIZE="$(echo "${FONTSIZE:-}" | awk -Fx '{print $NF}')"

# use FONTSIZE if CONSOLE_FONT is unset
if [ -z "${CONSOLE_FONT:-}" ] && [ -n "${FONTSIZE}" ] && [ "${FONTSIZE}" -eq "${FONTSIZE}" ] 2>/dev/null
then
    CONSOLE_FONT="ter-1$(echo "${FONTSIZE}" | awk -Fx '{print $NF}')n"
fi

# set a default CONSOLE_FONT
if [ -z "${CONSOLE_FONT:-}" ]
then
    CONSOLE_FONT="ter-116n"
fi

# set preferred console font
echo "Setting console font to ${CONSOLE_FONT}..."
setfont -C /dev/tty1 "/usr/share/consolefonts/${CONSOLE_FONT}.psf.gz"

# wait for FTLPORT to become available
while ! nc -z 127.0.0.1 "${FTLPORT}"
do
    echo "Waiting for FTL on port ${FTLPORT}..."
    sleep 5
done

# this is where PADD expects to find the ftlport
echo "${FTLPORT}" > /run/pihole-FTL.port

echo "Starting PADD..."
/usr/src/app/padd.sh 2>/dev/null >/dev/tty1
