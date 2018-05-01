#!/bin/sh

# create ssh dir if it doesn't exist
if [ ! -d "${HOME}/.ssh" ]
then
	mkdir -p "${HOME}/.ssh"
fi

# generate ssh key if one does not exist
if [ ! -f "${HOME}/.ssh/id_rsa" ]
then
	ssh-keygen -q -t "rsa" -N '' -f "${HOME}/.ssh/id_rsa" -C "$(id -un)@$(hostname) $(date)"
fi

# set permissions on ssh dir
chown -R root:root "${HOME}/.ssh"
chmod -R 700 "${HOME}/.ssh"

# generate ssh host keys
/usr/bin/ssh-keygen -A

# start ssh service
if [ "$INITSYSTEM" != "on" ]
then
	/usr/sbin/sshd -p 22 -D
else
	rc-service sshd start
fi
