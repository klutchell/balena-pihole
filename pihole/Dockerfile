# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2024.03.1@sha256:e3bb67ee283afee5fffd1d3ea8b95c4a2bf3aa445f955d4e5f3947d72904d580

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y console-setup dbus netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY cont-init.d/ /etc/cont-init.d/
COPY s6-overlay/ /etc/s6-overlay/

RUN chmod +x /etc/cont-init.d/10-custom.sh

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
