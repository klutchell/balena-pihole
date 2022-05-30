# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2022.05

WORKDIR /usr/src/app

COPY cont-init.d/ /etc/cont-init.d/
COPY services/ /etc/services.d/

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y console-setup dbus netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# https://github.com/pi-hole/PADD/releases
ARG PADD_VERSION=3.6.7
ARG PADD_SHA256=4b969387feda238213f0e5845edf1da42d9d5f889ef6576d2c8a66cfcebe1469

RUN curl -fsSL https://github.com/pi-hole/PADD/archive/v${PADD_VERSION}.tar.gz -o padd.tar.gz && \
	echo "${PADD_SHA256}  padd.tar.gz" | sha256sum -c - && \
	tar xzf padd.tar.gz --strip 1 && \
	rm padd.tar.gz && \
	chmod +x padd.sh

ENV INTERFACE eth0
ENV DNSMASQ_LISTENING single
ENV PIHOLE_DNS_ 1.1.1.1;1.0.0.1
ENV FONTFACE Terminus
ENV FONTSIZE 8x14
ENV WEBPASSWORD balena
ENV VIRTUAL_HOST balena-devices.com

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
