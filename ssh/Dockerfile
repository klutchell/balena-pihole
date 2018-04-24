FROM resin/raspberrypi3-alpine

# set timezone
RUN apk add --no-cache tzdata
ENV TZ=America/Toronto

# install git, openssh, and rsync
RUN apk add --no-cache \
	openssh \
	rsync

# adjust sshd config
RUN sed -i \
	-e 's/#PasswordAuthentication yes/PasswordAuthentication no/' \
	-e 's/#GatewayPorts no/GatewayPorts yes/' \
	/etc/ssh/sshd_config

COPY start.sh /usr/bin/start.sh

CMD [ "/usr/bin/start.sh" ]

