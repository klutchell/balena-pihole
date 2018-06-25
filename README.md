# resin-pihole

[resin.io](https://resin.io/) stack with the following services:
* [pi-hole dns server](https://pi-hole.net/)
* [duplicity backups](https://github.com/blacklabelops/volumerize)

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
|pi-hole|TZ|America/Toronto|
|pi-hole|WEBPASSWORD|secretwebpassword|
|volumerize|AWS_ACCESS_KEY_ID|QQWDQIWIDO1QO|
|volumerize|AWS_SECRET_ACCESS_KEY|ewlfkwkejflkjwlkej3fjw381|
|volumerize|PASSPHRASE|secretgpgpassword|
|volumerize|VOLUMERIZE_FULL_IF_OLDER_THAN|7D|
|volumerize|VOLUMERIZE_TARGET|s3://s3.eu-central-1.amazonaws.com/duplicitytest|

## Usage

browse to `http://<device-ip>:80` to access the pi-hole admin interface

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/diginc/docker-pi-hole
* https://github.com/blacklabelops/volumerize
