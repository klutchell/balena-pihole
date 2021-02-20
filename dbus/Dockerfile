FROM alpine:3.13.0

WORKDIR /usr/src/app

# hadolint ignore=DL3018
RUN apk add --no-cache dbus

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'

COPY init.sh .

RUN chmod +x ./init.sh

CMD [ "./init.sh" ]