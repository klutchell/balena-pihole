FROM alpine:3.22@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

# https://wiki.alpinelinux.org/wiki/Fonts
# hadolint ignore=DL3018
RUN apk add --no-cache curl dbus font-terminus kbd bash jq bind-tools

ENV DBUS_SYSTEM_BUS_ADDRESS='unix:path=/host/run/dbus/system_bus_socket'
ENV CONSOLE_FONT='ter-u16n'

WORKDIR /usr/local/bin

# renovate: datasource=github-releases depName=pi-hole/PADD
ARG PADD_VERSION=v4.0.0

RUN curl -fsSL https://raw.githubusercontent.com/pi-hole/PADD/refs/tags/${PADD_VERSION}/padd.sh -o ./padd \
    && chmod +x ./padd

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
