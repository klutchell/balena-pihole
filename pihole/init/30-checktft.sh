#!/usr/bin/with-contenv bash
# shellcheck shell=bash

if [ ! -e /dev/fb1 ]
then
    s6-echo "/dev/fb1 not found. Disabling fbcp & PADD"
    touch /etc/services.d/fbcp/down
    touch /etc/services.d/padd/down
    exit 0
fi

s6-echo "/dev/fb1 exists. Enabling fbcp & PADD"
rm -f /etc/services.d/fbcp/down
rm -f /etc/services.d/padd/down

# workaround for plymouth blocking fbcp
# https://github.com/klutchell/balena-pihole/issues/25
# https://github.com/balena-os/meta-balena/issues/1772
DBUS_SYSTEM_BUS_ADDRESS='unix:path=/host/run/dbus/system_bus_socket' \
    dbus-send \
    --system \
    --dest=org.freedesktop.systemd1 \
    --type=method_call \
    --print-reply \
    /org/freedesktop/systemd1 \
    org.freedesktop.systemd1.Manager.StartUnit \
    string:"plymouth-quit.service" string:"replace"

# fix for PADD fonts
# https://github.com/klutchell/balena-pihole/pull/28
sed -i "s/^FONTFACE.*/FONTFACE=\"${FONTFACE}\"/" /etc/default/console-setup
sed -i "s/^FONTSIZE.*/FONTSIZE=\"${FONTSIZE}\"/" /etc/default/console-setup
dpkg-reconfigure console-setup