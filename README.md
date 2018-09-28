# resin-pihole

[resin.io](https://resin.io/) stack with the following services:
* [pihole](https://hub.docker.com/r/pihole/pihole/)
* [cloudflared](https://hub.docker.com/r/visibilityspots/cloudflared/)
* [duplicati](https://hub.docker.com/r/lsioarmhf/duplicati/)
* [ubuntu](https://hub.docker.com/r/resin/raspberrypi3-ubuntu/)

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
|`duplicati`|`PGID`|`root`|
|`duplicati`|`PUID`|`root`|
|`pihole`|`DNS1`|`127.0.0.1#54`|
|`pihole`|`DNS2`|`127.0.0.1#54`|
|`pihole`|`DNSMASQ_LISTENING`|`eth0`|
|`pihole`|`INTERFACE`|`eth0`|
|`pihole`|`IPv6`|`False`|
|`pihole`|`ServerIP`|_[external device ip]_|
|`pihole`|`WEBPASSWORD`|_(optional)_|
|`ubuntu`|`GITHUB_USER`|_(optional)_|

## Usage

* browse to `http://<device-ip>:80/admin` to access the pi-hole admin interface
* browse to `http://<device-ip>:8200` to access the duplicati admin interface
* providing a `GITHUB_USER` value to the `ubuntu` service will download your authorized keys

## Author

Kyle Harding <kylemharding@gmail.com>

## License

[MIT License](./LICENSE)

## Acknowledgments

* https://github.com/resin-io-projects/multicontainer-getting-started
* https://github.com/resin-io-playground/resin-openssh
* https://github.com/pi-hole/docker-pi-hole/
* https://github.com/visibilityspots/dockerfile-cloudflared
* https://github.com/linuxserver/docker-duplicati-armhf
