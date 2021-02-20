#!/bin/sh

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

exit 0
