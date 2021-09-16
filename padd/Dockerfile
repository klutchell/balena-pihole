FROM alpine:3.12.8

WORKDIR /usr/src/app

# hadolint ignore=DL3018
RUN apk add --no-cache \
	ca-certificates bash curl kmod dbus netcat-openbsd procps iproute2 kbd terminus-font docker ncurses util-linux

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN curl -fsSL https://github.com/pi-hole/PADD/archive/v3.6.2.tar.gz | tar xz --strip-components 1 \
	&& chmod +x padd.sh

ENV FTLPORT 4711
ENV TERMINUS_FONT "ter-118n"
ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'

COPY run.sh ./

RUN chmod +x ./run.sh

CMD [ "/usr/src/app/run.sh" ]

COPY pihole.sh /usr/local/bin/pihole

RUN chmod +x /usr/local/bin/pihole
