#!/usr/bin/with-contenv bash

if [ -e /dev/fb1 ]; then
    s6-echo "/dev/fb1 exists. Enabling fbcp & PADD"
    rm /etc/services.d/fbcp/down || true
    rm /etc/services.d/padd/down || true
fi
