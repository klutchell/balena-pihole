FROM arm32v7/node

# set timezone
ENV TZ America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set the correct uname for rpi3
RUN cp "$(which uname)" "/bin/uname.orig" \
	&& echo '#!/bin/sh\n/bin/uname.orig $* | sed "s/armv8l/armv7l/"' > "$(which uname)"

# install updates and common utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-transport-https \
	bash-completion \
	ca-certificates \
	curl \
	tmux \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# work in app dir for cloud9
WORKDIR /usr/src/cloud9

# clone & install cloud9 core 
RUN git clone https://github.com/c9/core.git . \
	&& npm config set unsafe-perm true \
	&& scripts/install-sdk.sh

ENV C9_WORKSPACE /cloud9-workspace
CMD node server.js -p 8080 -w ${C9_WORKSPACE} -l 0.0.0.0 -a :

