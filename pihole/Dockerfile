# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2024.07.0@sha256:0def896a596e8d45780b6359dbf82fc8c75ef05b97e095452e67a0a4ccc95377

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y console-setup dbus netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY cont-init.d/ /etc/cont-init.d/
COPY s6-overlay/ /etc/s6-overlay/

RUN chmod +x /etc/cont-init.d/10-custom.sh

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
