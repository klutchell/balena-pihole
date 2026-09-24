FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

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
