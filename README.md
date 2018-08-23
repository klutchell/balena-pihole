# resin-pihole

[resin.io](https://resin.io/) stack with the following services:
* [pi-hole](https://pi-hole.net/)
* [duplicati](https://www.duplicati.com/)

## Getting Started

see https://docs.resin.io/learn/getting-started

## Deployment

### Application Environment Variables

|Name|Value|
|---|---|
|TZ|America/Toronto|

### Service Variables

|Service|Name|Value|
|---|---|---|
|pi-hole|DNS1|1.1.1.1|
|pi-hole|DNS2|1.0.0.1|
|pi-hole|ServerIP|192.168.86.12|
|pi-hole|WEBPASSWORD|secretwebpassword|

## Usage

* browse to `http://<device-ip>:80` to access the pi-hole admin interface
* browse to `http://<device-ip>:8200` to access the duplicati admin interface

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/diginc/docker-pi-hole
* https://github.com/linuxserver/docker-duplicati-armhf
