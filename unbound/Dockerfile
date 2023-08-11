# https://github.com/klutchell/unbound-docker
# https://hub.docker.com/r/klutchell/unbound
FROM klutchell/unbound:v1.17.1@sha256:e34f4d7f428e4e27ed4686918225c25eb2f580349ffe76870d13aba130205512

COPY custom.conf.d/*.conf /etc/unbound/custom.conf.d/

HEALTHCHECK NONE
