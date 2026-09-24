# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:v1.26.1@sha256:9a3939ca33d6d3b42b81a70391bb8e43f0a08d2bd7a3fdffb43d427493345c36

COPY etc/unbound/unbound.conf /etc/unbound/unbound.conf
COPY etc/unbound/custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
