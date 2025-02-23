#!/usr/bin/env bash

set -e

console=/dev/tty1

on_error() {
   echo "Exited with code ${?}, sleeping for a few seconds..."
   # Sleep for random amount of time between 5 and 20 seconds
   # before restarting and trying again...
   sleep $((RANDOM % 15 + 5))
}

# Trap all errors that are not container stop signals
trap on_error ERR

if [[ ! -e "${console}" ]]; then
   echo "Console '${console}' does not exist!"
   exit 1
fi

if [[ -z "${CONSOLE_FONT}" ]]; then
   echo "CONSOLE_FONT is not set!"
   exit 1
fi

# Quit the plymouth (balena logo) service so that we can use the TTY
echo "Stopping plymouth service..."
dbus-send \
   --system \
   --dest=org.freedesktop.systemd1 \
   --type=method_call \
   --print-reply \
   /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager.StartUnit \
   string:"plymouth-quit.service" string:"replace"


# https://wiki.alpinelinux.org/wiki/Fonts
# https://www.man7.org/linux/man-pages/man8/setfont.8.html
echo "Setting console font to ${CONSOLE_FONT}..."
setfont -C "${console}" /usr/share/consolefonts/"${CONSOLE_FONT}".psf.gz

# Calculate the size of the target tty rather than the current terminal session
stty_size="$(stty size -F "${console}")"
console_height="$(echo "${stty_size}" | awk '{print $1}')"
console_width="$(echo "${stty_size}" | awk '{print $2}')"

sed "s|console_height=.*|console_height=${console_height}|" -i /usr/local/bin/padd
sed "s|console_width=.*|console_width=${console_width}|" -i /usr/local/bin/padd

# Start the PADD script
echo "Starting PADD..."
/usr/local/bin/padd 2>/dev/null >"${console}"
