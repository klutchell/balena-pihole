FROM alpine:3.12.8

WORKDIR /usr/src/app

# hadolint ignore=DL3018
RUN apk add --no-cache \
	ca-certificates \
	bash \
	coreutils \
	curl \
	dbus \
	netcat-openbsd \
	procps \
	iproute2 \
	kbd \
	terminus-font \
	docker-cli \
	ncurses \
	sed \
	util-linux

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

ARG PADD_VERSION=3.6.2
ARG PADD_SHA256=7e1fcfefc5c24bd032b31ed79afceda21019faeb88535cdf15ba558b90141c01

RUN curl -fsSL https://github.com/pi-hole/PADD/archive/v${PADD_VERSION}.tar.gz -o padd.tar.gz && \
	echo "${PADD_SHA256}  padd.tar.gz" | sha256sum -c - && \
	tar xzf padd.tar.gz --strip 1 && \
	rm padd.tar.gz && \
	chmod +x padd.sh

ENV FTLPORT 4711
ENV CONSOLE_FONT "ter-116n"
ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'

COPY pihole.sh /usr/local/bin/pihole
RUN chmod +x /usr/local/bin/pihole

COPY run.sh ./
RUN chmod +x ./run.sh

CMD [ "/usr/src/app/run.sh" ]
