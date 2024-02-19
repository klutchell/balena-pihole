# https://hub.docker.com/r/pihole/pihole/tags
FROM pihole/pihole:2024.02.0@sha256:8077053835c2d2449041adad0c272d6e5fea3df91c5dfc3dae2bd950999c3118

ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y console-setup dbus netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY cont-init.d/ /etc/cont-init.d/
COPY s6-overlay/ /etc/s6-overlay/

RUN chmod +x /etc/cont-init.d/10-custom.sh

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'
