# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:development-v6

# https://wiki.alpinelinux.org/wiki/Fonts
# hadolint ignore=DL3018
RUN apk add --no-cache dbus font-terminus kbd

COPY balena-init.sh /

RUN chmod +x /balena-init.sh

ENTRYPOINT [ "tini", "--", "/balena-init.sh" ]

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
ENV CONSOLE_FONT 'ter-u16n'
