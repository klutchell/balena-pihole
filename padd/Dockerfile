FROM alpine:3.23@sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375

# https://wiki.alpinelinux.org/wiki/Fonts
# hadolint ignore=DL3018
RUN apk add --no-cache curl dbus font-terminus kbd bash jq bind-tools ncurses

ENV DBUS_SYSTEM_BUS_ADDRESS='unix:path=/host/run/dbus/system_bus_socket'
ENV CONSOLE_FONT='ter-u16n'

WORKDIR /usr/local/bin

# renovate: datasource=github-releases depName=pi-hole/PADD
ARG PADD_VERSION=v4.1.0

RUN curl -fsSL https://raw.githubusercontent.com/pi-hole/PADD/refs/tags/${PADD_VERSION}/padd.sh -o ./padd \
    && chmod +x ./padd

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
