# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:v1.26.0@sha256:5020cfe1218aeda38777f88279220162e602c3a44efc684550dbf46137106a16

COPY etc/unbound/unbound.conf /etc/unbound/unbound.conf
COPY etc/unbound/custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
