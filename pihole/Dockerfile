# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2025.02.3@sha256:83af1529136e39802e819e303b190e40147ac44c3e050398e1a53de6c0c701dd

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
# https://github.com/pi-hole/FTL/blob/ac500d5f1ff192d087209d6e9b955515c8f35434/test/pihole.toml#L627-L660
# ENV FTLCONF_webserver_port='80o,443os,[::]:80o,[::]:443os'

# enable inclusion of dnsmasq.d conf files
# https://github.com/pi-hole/FTL/pull/1734
ENV FTLCONF_misc_etc_dnsmasq_d='true'
