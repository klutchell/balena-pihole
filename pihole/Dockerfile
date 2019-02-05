FROM balenalib/raspberrypi3-debian:latest-build AS build

WORKDIR /usr/src

RUN install_packages cmake libraspberrypi-dev bc

RUN curl -sSL https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/master/CMakeLists.txt -O
RUN curl -sSL https://raw.githubusercontent.com/tasanakorn/rpi-fbcp/master/main.c -O

WORKDIR /usr/src/build

RUN cmake .. && make

FROM pihole/pihole:4.2.1_armhf

WORKDIR /usr/src

COPY --from=build /opt/vc/lib/* /opt/vc/lib/
COPY --from=build /usr/src/build/fbcp /usr/src/
COPY --from=build /usr/bin/bc /usr/bin/bc
COPY services/ /etc/services.d/
COPY init/ /etc/cont-init.d/

RUN sed -i '/$AUTHORIZED_HOSTNAMES = array(/ a "balena-devices.com",' /var/www/html/admin/scripts/pi-hole/php/auth.php

# https://serverfault.com/a/817791
# force dnsmasq to really bind only the interfaces it is listening on
# otherwise dnsmasq will fail to start since balena is using 53 on some interfaces
RUN echo "bind-interfaces" >> /etc/dnsmasq.conf

RUN curl -sSL https://raw.githubusercontent.com/jpmck/PADD/master/padd.sh -O \
	&& chmod +x padd.sh
