FROM debian:bullseye-20210902-slim

WORKDIR /usr/src/app

# required for dpkg-reconfigure to avoid interactive console-setup
ENV DEBIAN_FRONTEND noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install --no-install-recommends -y ca-certificates console-setup curl kmod dbus netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -fsSL https://github.com/pi-hole/PADD/archive/v3.6.2.tar.gz | tar xz --strip-components 1 \
	&& chmod +x padd.sh

ENV FTLPORT 4711
ENV FONTFACE Terminus
ENV FONTSIZE 8x14
ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'

COPY run.sh ./

RUN chmod +x ./run.sh

CMD [ "/usr/src/app/run.sh" ]
