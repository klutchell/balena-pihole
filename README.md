# resin-pihole

[resin.io](https://resin.io/) stack with the following services:
* pi-hole dns server
* cloud9 ide
* secure shell
* rsnapshot

## Getting Started

* https://github.com/pi-hole/pi-hole/wiki/Getting-Started
* https://docs.resin.io/learn/getting-started
* https://docs.c9.io/docs/getting-started
* http://rsnapshot.org/rsnapshot/docs/docbook/rest.html

## Deployment

```bash
git push resin master
```

## Usage

* http://your-device-ip:80 for pi-hole admin
* http://your-device-ip:8080 for cloud9 ide
* root@your-device-ip:22 for secure shell
* https://github.com/klutchell/resin-rsnapshot/blob/master/README.md

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/c9/install
* https://github.com/hwegge2/rpi-cloud9-ide
* https://github.com/resin-io-projects/resin-openssh
