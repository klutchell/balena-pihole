# resin-pihole

[resin.io](https://resin.io/) stack with the following services:
* [pi-hole dns server](https://pi-hole.net/)
* [cloud9 web ide](https://c9.io/)
* [ssh server](https://www.ssh.com/ssh/)

## Getting Started

* https://docs.resin.io/learn/getting-started

## Deployment

```yaml
# example docker-compose.yml
version: '2.1'

volumes:

  pi-hole-data:
  dnsmasq-data:
  ssh-data:

services:

  pi-hole:
    image: diginc/pi-hole-multiarch:debian_armhf
    ports:
      - '80:80'
      - '192.168.86.12:53:53/tcp'
      - '192.168.86.12:53:53/udp'
    volumes:
      - 'pi-hole-data:/etc/pihole'
      - 'dnsmasq-data:/etc/dnsmasq.d'

  cloud9:
    build: ./cloud9
    ports:
      - '8080:8080'
    volumes:
      - 'ssh-data:/root/.ssh'
      - 'pi-hole-data:/data'

  ssh:
    image: klutchell/resin-ssh
    ports:
      - '22:22'
    volumes:
      - 'ssh-data:/root/.ssh'
      - 'pi-hole-data:/data'
```

## Usage

* [docker-pi-hole](https://github.com/diginc/docker-pi-hole)
* [cloud9](cloud9/README.md)
* [ssh](https://github.com/klutchell/resin-ssh)

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/diginc/docker-pi-hole
