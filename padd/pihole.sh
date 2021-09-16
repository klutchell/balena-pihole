#!/usr/bin/env sh

# stub to proxy pihole commands to pihole binary in another container

id="$(docker ps --quiet --filter "label=io.pihole")"
docker exec "${id}" pihole "$@"
