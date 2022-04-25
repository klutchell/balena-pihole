#!/usr/bin/env bash

set -e

depName="${1}"
newVersion="${2}"

if [ "${depName}" != "pihole/pihole" ]
then
    echo "skipping dependency ${depName}!"
    exit 0
fi

re='^0*([1-9][0-9]*)\.0*([1-9][0-9]*)\.0*([1-9][0-9]*)$'

if [[ "${newVersion}" =~ $re ]]
then
    semver="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${BASH_REMATCH[3]}"
    sed "s/^version: .*$/version: ${semver}/" -i balena.yml
else 
    echo "${newVersion} is not a supported version string!"
    exit 1
fi
