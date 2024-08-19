# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:1.21.0@sha256:41a37ebbfc522155cc68c21b783f7b30f041438ae1c3c1ab011cd2e73c1624c5

COPY etc/unbound/unbound.conf /etc/unbound/unbound.conf
COPY etc/unbound/custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
