# balena-pihole

[balena.io](https://www.balena.io/) stack with the following services:
* [pihole](https://hub.docker.com/r/pihole/pihole/)
* [cloudflared](https://hub.docker.com/r/visibilityspots/cloudflared/)
* [unbound](https://hub.docker.com/r/klutchell/unbound/)
* [duplicati](https://hub.docker.com/r/lsioarmhf/duplicati/)
* [dind](https://hub.docker.com/r/klutchell/dind/)

## Getting Started

see https://www.balena.io/docs/learn/getting-started

## Deployment

### Application Environment Variables

|Name|Value|
|---|---|
|`TZ`|`America/Toronto`|

### Service Variables

|Service|Name|Value|
|---|---|---|
|`duplicati`|`PGID`|`root`|
|`duplicati`|`PUID`|`root`|
|`pihole`|`DNS1`|`127.0.0.1#1053`|
|`pihole`|`DNS2`|`127.0.0.1#1053`|
|`pihole`|`DNSMASQ_LISTENING`|`eth0`|
|`pihole`|`INTERFACE`|`eth0`|
|`pihole`|`IPv6`|`False`|
|`pihole`|`ServerIP`|_[external device ip]_|
|`pihole`|`WEBPASSWORD`|_(optional)_|
|`dind`|`GITHUB_USER`|_(optional)_|

## Usage

* browse to `http://<device-ip>:80/admin` to access the pi-hole admin interface
* browse to `http://<device-ip>:8200` to access the duplicati admin interface
* providing a `GITHUB_USER` value to the `dind` service will sync your authorized keys

## Author

Kyle Harding <kylemharding@gmail.com>

## License

[MIT License](./LICENSE)

## Acknowledgments

* https://github.com/balena-io-projects/multicontainer-getting-started
* https://github.com/balena-io-playground/balena-openssh
* https://github.com/pi-hole/docker-pi-hole/
* https://github.com/visibilityspots/dockerfile-cloudflared
* https://github.com/linuxserver/docker-duplicati-armhf
* https://github.com/MatthewVance/unbound-docker