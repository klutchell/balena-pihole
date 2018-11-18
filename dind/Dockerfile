FROM resin/raspberrypi3-ubuntu

LABEL maintainer="kylemharding@gmail.com"

# start cross-build
RUN [ "cross-build-start" ]

# default timezone
ENV TZ America/Toronto

# avoid prompts during package installation
ENV DEBIAN_FRONTEND noninteractive

# install updates and common utilities
RUN apt-get update && apt-get install -yq --no-install-recommends \
	apt-transport-https \
	aufs-tools \
	bash-completion \
	build-essential \
	ca-certificates \
	cgroupfs-mount \
	curl \
	git \
	gnupg2 \
	openssh-server \
	software-properties-common \
	sudo \
	tmux \
	tzdata \
	wget \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# disable ssh password auth
RUN sed -r \
	-e 's/^(#)?PasswordAuthentication .+$/PasswordAuthentication no/' \
	-i /etc/ssh/sshd_config

# create privilege separation directory
RUN mkdir /run/sshd

# install docker
RUN curl -fsSL https://get.docker.com | sh \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# use volume for docker graph
VOLUME /var/lib/docker

# install rmate
RUN curl -fsSL https://raw.githubusercontent.com/aurora/rmate/master/rmate -o /usr/local/bin/rmate \
	&& chmod a+x /usr/local/bin/rmate

# create user account
RUN adduser --disabled-password --gecos '' dind \
	&& adduser dind sudo \
	&& adduser dind docker \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# end cross-build
RUN [ "cross-build-end" ]

# switch to dind user
USER dind

# work in home dir
WORKDIR /home/dind

# expose ssh port
EXPOSE 22

# set default shell to bash
ENV SHELL /bin/bash

# copy start script
COPY start.sh /

# run start script on boot
CMD ["/bin/sh", "/start.sh"]
