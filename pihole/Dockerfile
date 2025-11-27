# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2025.11.1@sha256:91dc91ddd413bf461c283204558f8f21839851e9824799075a7ceff7c77eea40

# https://wiki.alpinelinux.org/wiki/Fonts
# hadolint ignore=DL3018
RUN apk add --no-cache bash

# Avoid port conflicts in 53 with the resin-dns interface
# https://docs.pi-hole.net/ftldns/interfaces/
RUN mkdir -p /etc/dnsmasq.d && \
    echo "bind-interfaces" >/etc/dnsmasq.d/90-resin-dns.conf && \
    echo "except-interface=resin-dns" >>/etc/dnsmasq.d/90-resin-dns.conf

# enable inclusion of dnsmasq.d conf files
# https://github.com/pi-hole/FTL/pull/1734
ENV FTLCONF_misc_etc_dnsmasq_d='true'

COPY balena-init.sh /

RUN chmod +x /balena-init.sh

ENTRYPOINT [ "/balena-init.sh" ]

# https://docs.pi-hole.net/docker/configuration/?h=pihole+ftl#configuration
# https://docs.pi-hole.net/docker/upgrading/v5-v6/?h=web_bind_addr#removed-variables
ENV FTLCONF_dns_listeningMode='all'
ENV FTLCONF_dns_upstreams='1.1.1.1;1.0.0.1'
ENV FTLCONF_webserver_api_password='balena'
# https://github.com/pi-hole/FTL/blob/ac500d5f1ff192d087209d6e9b955515c8f35434/test/pihole.toml#L627-L660
# ENV FTLCONF_webserver_port='80o,443os,[::]:80o,[::]:443os'
