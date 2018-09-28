#!/bin/sh

# set timezone with TZ
# eg. TZ=America/Toronto
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# generate ssh key if one does not exist
if [ ! -f "/root/.ssh/id_rsa" ]
then
	ssh-keygen -q -N '' -f "/root/.ssh/id_rsa"
fi

# if a github username was provided and authorized_keys does not exist
if [ ! -f "/root/.ssh/authorized_keys" ] && [ -n "${GITHUB_USER}" ]
then
	curl "https://github.com/${GITHUB_USER}.keys" > "/root/.ssh/authorized_keys"
fi

# set permissions on ssh dir
chown -R root:root "/root/.ssh"
chmod -R 700 "/root/.ssh"

if [ "${INITSYSTEM}" != "on" ]
then
	# start sshd service in background
	/usr/sbin/sshd -p 22 -D &
	
	# start docker daemon in the background
	/usr/bin/dockerd ${DIND_OPTS} &
fi

