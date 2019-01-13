# balena-pihole

[balena.io](https://www.balena.io/) stack with the following services:
* [pihole](https://hub.docker.com/r/pihole/pihole/)
* [unbound](https://hub.docker.com/r/klutchell/unbound/)

## Getting Started

https://www.balena.io/docs/learn/getting-started

## Deployment

### Application Environment Variables

|Name|Value|
|---|---|
|`TZ`|`America/Toronto`|

### Service Variables

|Service|Name|Value|
|---|---|---|
|`pihole`|`DNS1`|`127.0.0.1#1053`|
|`pihole`|`DNS2`|`127.0.0.1#1053`|
|`pihole`|`DNSMASQ_LISTENING`|`eth0`|
|`pihole`|`INTERFACE`|`eth0`|
|`pihole`|`IPv6`|`False`|
|`pihole`|`ServerIP`|_[external device ip]_|
|`pihole`|`WEBPASSWORD`|_(optional)_|

## Usage

https://docs.pi-hole.net/guides/unbound/

## Author

Kyle Harding <kylemharding@gmail.com>

## License

[MIT License](./LICENSE)

## Acknowledgments

* https://github.com/balena-io-projects/multicontainer-getting-started
* https://github.com/balena-io-playground/balena-openssh
* https://github.com/pi-hole/docker-pi-hole/