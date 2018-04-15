#!/bin/bash

# replace one or more spaces with a single tab
spaces_to_tabs()	{ echo "${1}" | sed 's| \+|\t|g' ; }

# create ssh dir if it doesn't exist
if [ ! -d "${HOME}/.ssh" ]
then
	mkdir -p "${HOME}/.ssh"
fi

# generate ssh key to connect to other authenticated systems
if [ ! -f "${HOME}/.ssh/id_rsa" ]
then
	ssh-keygen -q -t "rsa" -N '' -f "${HOME}/.ssh/id_rsa" -C "$(id -un)@$(hostname) $(date)"
fi

# generate ssh config file to prevent caching known hosts
if [ ! -f "${HOME}/.ssh/config" ]
then
	cat <<EOF >> "${HOME}/.ssh/config"

Host *
	StrictHostKeyChecking no
	UserKnownHostsFile /dev/null"

EOF
fi

# set permissions on ssh dir
chown -R root:root "${HOME}/.ssh"
chmod -R 700 "${HOME}/.ssh"

# mount device with LABEL="snapshot" if it exists
part_label="snapshots"
dev_path="$(blkid | grep "LABEL=\"$part_label\"" | cut -d: -f1)"
mount_path="/snapshots"
if [ -n "$dev_path" ]
then
	echo "mounting $dev_path onto $mount_path ..."
	mount "$dev_path" "$mount_path"
else
	echo "no devices with label '$part_label' found!"
	exit 1
fi

# append RSNAPSHOT_CONF_* environment variables to rsnapshot.conf
echo "updating rsnapshot config ..."
rsnapshot_config="/etc/rsnapshot.conf"
for var in $(compgen -A variable | grep "^RSNAPSHOT_CONF_")
do
	if [ -n "$(eval "echo \$${var}")" ]
	then
		eval "echo + \$${var}"
		spaces_to_tabs "$(eval "echo \$${var}")" >> "${rsnapshot_config}"
	fi
done

# test rsnapshot config syntax
echo "checking rsnapshot config ..."
/usr/bin/rsnapshot -c "${rsnapshot_config}" configtest || exit 1

# print cron schedule in human readable format
echo "reading rsnapshot schedule ..."
# skip whitespace and comments
grep -v '^\s*#' "/etc/crontabs/root" | grep -v '^\s*$' | while IFS=$'\n' read -r line
do
	exp="$(echo "${line}" | awk '{print $1"+"$2"+"$3"+"$4"+"$5}')"
	sched="$(curl -s --retry 3 "https://cronexpressiondescriptor.azurewebsites.net/api/descriptor/?expression=${exp}&locale=en-US" | awk -F '"' '{print $4}')"
	echo "+ ${sched:-$exp}"
done

# start cron in foreground
/usr/sbin/crond -f
