#!/usr/bin/with-contenv bash

if [ -e /dev/fb1 ]; then
    s6-echo "/dev/fb1 exists. Enabling fbcp & PADD"
    rm -f /etc/services.d/fbcp/down
    rm -f /etc/services.d/padd/down
else
    s6-echo "/dev/fb1 not found. Disabling fbcp & PADD"
    touch /etc/services.d/fbcp/down
    touch /etc/services.d/padd/down
fi
