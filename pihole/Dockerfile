# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2026.09.0@sha256:5b9c8cf51de7d6d3f2240dbe72baf5f06e1fd39cb4d77a99fab4fa13e23bd1be

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
# The password is a documented default, not a secret. Users override it per fleet.
# hadolint ignore=DL3064
ENV FTLCONF_webserver_api_password='balena'
# https://github.com/pi-hole/FTL/blob/ac500d5f1ff192d087209d6e9b955515c8f35434/test/pihole.toml#L627-L660
# ENV FTLCONF_webserver_port='80o,443os,[::]:80o,[::]:443os'
