# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:1.24.1@sha256:e506a417d3e3673a259bb1c2cd2e843cf20b3847f3f33853f785395766a5d3c4

COPY etc/unbound/unbound.conf /etc/unbound/unbound.conf
COPY etc/unbound/custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
