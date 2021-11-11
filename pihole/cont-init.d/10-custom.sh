#!/usr/bin/with-contenv bash
# shellcheck shell=bash

set -e

pihole -a -p "${WEBPASSWORD}" || true
