#!/bin/sh

set -eu

fwd_addr="$(getent hosts "${FORWARD_SERVICE}" | awk '{ print $1 }')"
fwd_port="${FORWARD_PORT}"
comment="${FORWARD_COMMENT:-'my-custom-rules'}" # don't change this unless you want rules leftover
helper_image="$(docker inspect --format '{{ .Image }}' "$(hostname)")"

helper_cmd() {
    docker run --rm --network host --privileged "${helper_image}" /bin/sh -c "${@}"
}

cleanup() {
    helper_cmd "iptables-save | grep -v 'comment ${comment}' | iptables-restore" || true
}

# cleanup custom rules before creating new ones
cleanup

# try to cleanup custom rules when exiting
trap "cleanup" EXIT

# https://forums.docker.com/t/how-to-expose-port-on-running-container/3252/11
# https://stackoverflow.com/questions/19335444/how-do-i-assign-a-port-mapping-to-an-existing-docker-container/47172091#47172091
for proto in ${FORWARD_PROTOCOLS:-tcp udp}
do
    helper_cmd "
        iptables -v -t nat -A DOCKER -p ${proto} --dport ${fwd_port} -j DNAT --to-destination ${fwd_addr}:${fwd_port} -m comment --comment ${comment} &&
        iptables -v -t nat -A POSTROUTING -j MASQUERADE -p ${proto} --source ${fwd_addr} --destination ${fwd_addr} --dport ${fwd_port} -m comment --comment ${comment} &&
        iptables -v -t filter -A DOCKER -j ACCEPT -p ${proto} --destination ${fwd_addr} --dport ${fwd_port} -m comment --comment ${comment}
    "
done

# print custom rules to logs
helper_cmd "iptables-save | grep 'comment ${comment}'"

# check frequently that the forward service IP hasn't changed
while [ "$(getent hosts "${FORWARD_SERVICE}" | awk '{ print $1 }')" = "${fwd_addr}" ]
do
    sleep 5
done
