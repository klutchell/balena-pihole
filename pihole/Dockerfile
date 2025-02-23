# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2025.02.4@sha256:d83cd1ca243eace24c9d2f7320634eb47dee06dcdacb15247fdc1e30efd69438

# https://wiki.alpinelinux.org/wiki/Fonts
# hadolint ignore=DL3018
RUN apk add --no-cache dbus font-terminus kbd bash

COPY balena-init.sh /

RUN chmod +x /balena-init.sh

ENTRYPOINT [ "/balena-init.sh" ]

ENV DBUS_SYSTEM_BUS_ADDRESS='unix:path=/host/run/dbus/system_bus_socket'
ENV CONSOLE_FONT='ter-u16n'

# https://docs.pi-hole.net/docker/configuration/?h=pihole+ftl#configuration
# https://docs.pi-hole.net/docker/upgrading/v5-v6/?h=web_bind_addr#removed-variables
ENV FTLCONF_dns_listeningMode='all'
ENV FTLCONF_dns_upstreams='1.1.1.1;1.0.0.1'
ENV FTLCONF_webserver_api_password='balena'
ENV FTLCONF_webserver_port='80,443s'

# enable inclusion of dnsmasq.d conf files
# https://github.com/pi-hole/FTL/pull/1734
ENV FTLCONF_misc_etc_dnsmasq_d='true'
