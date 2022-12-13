# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2022.11.2

WORKDIR /usr/src/app

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y console-setup dbus netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# https://github.com/pi-hole/PADD/releases
ARG PADD_VERSION=v3.9.0

RUN curl -fsSL https://github.com/pi-hole/PADD/archive/${PADD_VERSION}.tar.gz -o padd.tar.gz && \
	tar xzf padd.tar.gz --strip 1 && \
	rm padd.tar.gz && \
	chmod +x padd.sh

COPY cont-init.d/ /etc/cont-init.d/
COPY services/ /etc/services.d/

RUN chmod +x /etc/cont-init.d/10-custom.sh && \
	chmod +x /etc/services.d/padd/*

ENV INTERFACE eth0
ENV DNSMASQ_LISTENING single
ENV PIHOLE_DNS_ 1.1.1.1;1.0.0.1
ENV FONTFACE Terminus
ENV FONTSIZE 8x14
ENV WEBPASSWORD balena
ENV VIRTUAL_HOST balena-devices.com

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
