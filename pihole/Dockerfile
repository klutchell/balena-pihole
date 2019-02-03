FROM balenalib/raspberrypi3-debian:latest-build AS build

WORKDIR /usr/src

RUN install_packages cmake libraspberrypi-dev

RUN curl -sSL https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/master/CMakeLists.txt -O
RUN curl -sSL https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/master/main.c -O

WORKDIR /usr/src/build

RUN cmake .. && make

FROM pihole/pihole:v4.2_rc2_armhf

WORKDIR /usr/src

COPY --from=build /opt/vc/lib/* /opt/vc/lib/
COPY --from=build /usr/src/build/fbcp /usr/src/
COPY services/ /etc/services.d/

RUN sed -i '/$AUTHORIZED_HOSTNAMES = array(/ a "balena-devices.com",' /var/www/html/admin/scripts/pi-hole/php/auth.php

RUN curl -sSL https://raw.githubusercontent.com/jpmck/PADD/master/padd.sh -O \
	&& chmod +x padd.sh
