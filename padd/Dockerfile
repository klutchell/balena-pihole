FROM alpine:3.23@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62

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
