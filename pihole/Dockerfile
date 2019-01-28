FROM balenalib/raspberrypi3-debian:latest-build AS build

RUN mkdir -p /usr/src
WORKDIR /usr/src

RUN apt-get update && apt-get install -y --no-install-recommends \
  cmake \
  libraspberrypi-dev

RUN wget https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/master/CMakeLists.txt
RUN wget https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/master/main.c

RUN mkdir build
WORKDIR /usr/src/build
RUN cmake ..
RUN make

FROM pihole/pihole:4.1.1_armhf

RUN mkdir -p /usr/src
WORKDIR /usr/src

COPY --from=build /opt/vc/lib/* /opt/vc/lib/
COPY --from=build /usr/src/build/fbcp /usr/src/
COPY services/ /etc/services.d/

RUN sed -i '/$AUTHORIZED_HOSTNAMES = array(/ a "balena-devices.com",' /var/www/html/admin/scripts/pi-hole/php/auth.php
RUN wget https://raw.githubusercontent.com/jpmck/PADD/master/padd.sh
RUN chmod +x padd.sh
