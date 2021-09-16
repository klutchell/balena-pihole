FROM pihole/pihole:2021.09

WORKDIR /usr/src/app

COPY cont-init.d/ /etc/cont-init.d/
COPY services/ /etc/services.d/

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y console-setup kmod dbus && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# hadolint ignore=SC2016
RUN sed '/$AUTHORIZED_HOSTNAMES = array(/ a "balena-devices.com",' -i /var/www/html/admin/scripts/pi-hole/php/auth.php

# https://serverfault.com/a/817791
# force dnsmasq to bind only the interfaces it is listening on
# otherwise dnsmasq will fail to start since balena is using 53 on some interfaces
RUN echo "bind-interfaces" >> /etc/dnsmasq.conf

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL https://github.com/pi-hole/PADD/archive/v3.6.2.tar.gz | tar xz --strip-components 1 \
	&& chmod +x padd.sh

ENV INTERFACE eth0
ENV DNSMASQ_LISTENING single
ENV PIHOLE_DNS_ 1.1.1.1;1.0.0.1
ENV FONTFACE Terminus
ENV FONTSIZE 8x14
ENV WEBPASSWORD balena

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
