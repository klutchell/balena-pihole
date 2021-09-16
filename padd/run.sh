#!/usr/bin/env bash

set -e

echo "Stopping plymouth service..."

# prevent plymouth from blocking fbcp
# https://github.com/klutchell/balena-pihole/issues/25
# https://github.com/balena-os/meta-balena/issues/1772
dbus-send \
    --system \
    --dest=org.freedesktop.systemd1 \
    --type=method_call \
    --print-reply \
    /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager.StartUnit \
    string:"plymouth-quit.service" string:"replace"

echo "Configuring console..."

# fix for PADD fonts
sed -i "s/^FONTFACE.*/FONTFACE=\"${FONTFACE}\"/" /etc/default/console-setup
sed -i "s/^FONTSIZE.*/FONTSIZE=\"${FONTSIZE}\"/" /etc/default/console-setup
dpkg-reconfigure console-setup 2> /dev/null > /dev/tty1

# wait for tcp://127.0.0.1:$FTLPORT to become available
while ! nc -z 127.0.0.1 "${FTLPORT}"
do
    echo "Waiting for FTL on port ${FTLPORT}..."
    sleep 5
done

echo "Starting PADD..."

# this is where PADD expects to find the ftlport
echo "${FTLPORT}" > /run/pihole-FTL.port
/usr/src/app/padd.sh 2> /dev/null > /dev/tty1
