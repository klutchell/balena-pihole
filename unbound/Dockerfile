# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:v1.20.0@sha256:7f8bd396b3b82e0502803f0b1c2e7a635ec8bccd973763a5a95a3c9d2b72e07d

COPY etc/unbound/unbound.conf /etc/unbound/unbound.conf
COPY etc/unbound/custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
