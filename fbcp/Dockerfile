FROM balenalib/raspberrypi3-debian:jessie-build AS build

WORKDIR /usr/src

RUN install_packages cmake libraspberrypi-dev

RUN curl -sSL https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/af8d32246c23cb23e4030e6588668a14341f5ddc/CMakeLists.txt -O
RUN curl -sSL https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/af8d32246c23cb23e4030e6588668a14341f5ddc/main.c -O

WORKDIR /usr/src/build

RUN cmake .. && make

FROM balenalib/raspberrypi3-debian:jessie-run

WORKDIR /usr/src/app

COPY --from=build /opt/vc/lib/* /opt/vc/lib/
COPY --from=build /usr/src/build/fbcp /usr/src/app/

RUN install_packages dbus

ENV DBUS_SYSTEM_BUS_ADDRESS 'unix:path=/host/run/dbus/system_bus_socket'

COPY init.sh .

RUN chmod +x init.sh

CMD [ "./init.sh" ]
