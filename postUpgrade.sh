#!/usr/bin/env bash

set -e

re='^0*([1-9][0-9]*)\.0*([1-9][0-9]*)\.0*([1-9][0-9]*)$'

if [[ "${1}" =~ $re ]]
then
    semver="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${BASH_REMATCH[3]}"
    sed "s/^version: .*$/version: ${semver}/" -i balena.yml
else 
    echo "${1} is not a supported version string!"
    exit 1
fi
