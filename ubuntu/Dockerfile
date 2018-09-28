FROM resin/raspberrypi3-ubuntu

LABEL maintainer="kylemharding@gmail.com"

# default timezone
ENV TZ America/Toronto

# docker-in-docker daemon options
ENV DIND_OPTS ""

# enable systemd
ENV INITSYSTEM on

# avoid prompts during package installation
ENV DEBIAN_FRONTEND noninteractive

# install updates and common utilities
RUN apt-get update && apt-get install -yq --no-install-recommends \
	apt-transport-https \
	aufs-tools \
	bash-completion \
	ca-certificates \
	curl \
	git \
	gnupg2 \
	openssh-server \
	software-properties-common \
	sudo \
	tmux \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add docker-ce repo
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
	&& echo "deb [arch=armhf] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" | \
	tee /etc/apt/sources.list.d/docker.list

# install docker-ce
RUN apt-get update && apt-get install -yq --no-install-recommends \
	docker-ce \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add custom flags to docker service
RUN sed -r \
	-e "s|^(ExecStart=.+)$|\1 ${DIND_OPTS}|" \
	-i /lib/systemd/system/docker.service

# disable ssh password auth
RUN sed -r \
	-e 's/^(#)?PasswordAuthentication .+$/PasswordAuthentication no/' \
	-i /etc/ssh/sshd_config

# work in app dir
WORKDIR /usr/src/app

# copy src files
COPY start.sh ./

# volumes for home dir and docker graph
VOLUME /root /var/lib/docker

# work in home dir
WORKDIR /root

# run start script on boot
CMD ["/bin/sh", "/usr/src/app/start.sh"]

