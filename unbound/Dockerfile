# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:v1.17.1

COPY custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
