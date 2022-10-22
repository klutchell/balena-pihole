# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:v1.17.0

COPY custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
