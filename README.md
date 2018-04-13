# resin-pihole

[resin.io](https://resin.io/) stack with the following services:
* [pi-hole dns server](https://pi-hole.net/)
* [rsnapshot backups](http://rsnapshot.org/)
* [cloud9 web ide](c9.io)
* [ssh server](https://www.ssh.com/ssh/)

## Getting Started

* https://docs.resin.io/learn/getting-started

## Deployment

```yaml
# example docker-compose.yml
version: '2.1'

volumes:
  pihole-data:
  ssh-data:
  dnsmasq-data:

services:

  pihole:
    image: diginc/pi-hole-multiarch:debian_armhf
    ports:
      - '192.168.86.12:80:80'
      - '192.168.86.12:53:53/tcp'
      - '192.168.86.12:53:53/udp'
    volumes:
      - 'pihole-data:/etc/pihole/'
      - 'dnsmasq-data:/etc/dnsmasq.d/'

  cloud9:
    build: ./cloud9
    ports:
      - '8080:8080'
    volumes:
      - 'pihole-data:/data'
      - 'ssh-data:/root/.ssh'

  ssh:
    build: ./ssh
    ports:
      - '22:22'
    volumes:
      - 'pihole-data:/data'
      - 'ssh-data:/root/.ssh'

  rsnapshot:
    build: ./rsnapshot
    volumes: 
      - 'pihole-data:/data'
      - 'ssh-data:/root/.ssh'
    privileged: true
```

## Usage

* [docker-pi-hole](https://github.com/diginc/docker-pi-hole)
* [cloud9](cloud9/README.md)
* [ssh](ssh/README.md)
* [rsnapshot](rsnapshot/README.md)

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/diginc/docker-pi-hole
