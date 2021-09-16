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

# prevent dmesg from printing to console
dmesg -n 1

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
