# resin-ssh

[ssh](https://www.ssh.com/ssh/) service for [resin.io](https://resin.io/) stacks.

## Getting Started

* https://docs.resin.io/learn/getting-started
* https://www.ssh.com/ssh/#sec-Running-amp-configuring-SSH

## Deployment

```yaml
# example docker-compose.yml
version: '2.1'

volumes:
  ssh-data:

services:
  ssh:
    build: ./ssh
    ports:
      - '22:22'
    volumes:
      - 'ssh-data:/root/.ssh'
```

## Usage

1. use the `ssh` [resin web terminal](https://docs.resin.io/learn/manage/ssh-access/#using-the-dashboard-web-terminal)
to add public keys to `/root/.ssh/authorized_keys`
2. connect to secure shell as `root` on port `22`:
```bash
# example
ssh root@192.168.1.101:22
```

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/resin-io-projects/resin-openssh

