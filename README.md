# resin-pihole

[resin.io](https://resin.io/) stack with the following services:
* [pihole](https://hub.docker.com/r/pihole/pihole/)
* [duplicati](https://hub.docker.com/r/lsioarmhf/duplicati/)
* [cloud9](https://hub.docker.com/r/klutchell/cloud9/)
* [ssh](https://hub.docker.com/r/klutchell/ssh/)
* [cloudflared](https://hub.docker.com/r/visibilityspots/cloudflared/)

## Getting Started

see https://docs.resin.io/learn/getting-started

## Deployment

### Application Environment Variables

|Name|Value|
|---|---|
|`TZ`|`America/Toronto`|

### Service Variables

|Service|Name|Value|
|---|---|---|
|`cloud9`|`C9_USER`|_(optional)_|
|`cloud9`|`C9_PASS`|_(optional)_|
|`duplicati`|`PGID`|`root`|
|`duplicati`|`PUID`|`root`|
|`pihole`|`DNS1`|`127.0.0.1#54`|
|`pihole`|`DNS2`|`127.0.0.1#54`|
|`pihole`|`DNSMASQ_LISTENING`|`eth0`|
|`pihole`|`INTERFACE`|`eth0`|
|`pihole`|`IPv6`|`False`|
|`pihole`|`ServerIP`|_[external device ip]_|
|`pihole`|`WEBPASSWORD`|_(optional)_|
|`ssh`|`GITHUB_USER`|_(optional)_|

## Usage

* browse to `http://<device-ip>:80/admin` to access the pi-hole admin interface
* browse to `http://<device-ip>:8200` to access the duplicati admin interface
* browse to `http://<device-ip>:8080` to access the cloud9 web interface
* providing a `GITHUB_USER` value to the `ssh` service will sync your authorized keys

## Author

Kyle Harding <kylemharding@gmail.com>

## License

[MIT License](./LICENSE)

## Acknowledgments

* https://github.com/resin-io-projects/multicontainer-getting-started
* https://github.com/pi-hole/docker-pi-hole/
* https://github.com/visibilityspots/dockerfile-cloudflared
* https://github.com/linuxserver/docker-duplicati-armhf
* https://github.com/klutchell/docker-ssh
* https://github.com/klutchell/docker-cloud9
