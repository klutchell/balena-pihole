# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2023.10.0@sha256:562766abc805d5005bb2d2aa5d4bbf2d9b347380b1ea4504fb59b2100500f672

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y console-setup dbus netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY cont-init.d/ /etc/cont-init.d/
COPY s6-overlay/ /etc/s6-overlay/

RUN chmod +x /etc/cont-init.d/10-custom.sh

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
