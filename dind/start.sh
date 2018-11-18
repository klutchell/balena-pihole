#!/bin/sh

# set timezone with TZ
# eg. TZ=America/Toronto
sudo ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime
echo "${TZ}" | sudo tee /etc/timezone

# set permissions on ssh dir
[ ! -d "${HOME}/.ssh" ] && mkdir "${HOME}/.ssh"
chown -R dind:dind "${HOME}/.ssh"
chmod -R 700 "${HOME}/.ssh"

# if a github username was provided and authorized_keys does not exist
if [ ! -f "${HOME}/.ssh/authorized_keys" ] && [ -n "${GITHUB_USER}" ]
then
	curl -fsSL "https://github.com/${GITHUB_USER}.keys" > "${HOME}/.ssh/authorized_keys"
fi

# start sshd service in background
sudo /usr/sbin/sshd -p 22 -D &

# start docker daemon in the foreground
# sudo /usr/bin/dockerd ${DIND_OPTS}

/bin/bash
