# resin-rsnapshot

[rsnapshot](http://rsnapshot.org/) service for [resin.io](https://resin.io/) stacks.

## Getting Started

* https://docs.resin.io/learn/getting-started
* http://rsnapshot.org/rsnapshot/docs/docbook/rest.html

## Deployment

```yaml
# example docker-compose.yml
version: '2.1'

volumes:
  rsnapshot-data:

services:
  rsnapshot:
    build: ./rsnapshot
    volumes:
      - 'rsnapshot-data:/data'
    privileged: true
```

## Usage

1. use the `Host OS` [resin web terminal](https://docs.resin.io/learn/manage/ssh-access/#using-the-dashboard-web-terminal)
and format a storage device with `snapshots` label:
```bash
# example
fdisk /dev/sda
d
n
w
mkfs.ext4 /dev/sda1 -L snapshots
```

2. add [resin service variables](https://docs.resin.io/learn/manage/serv-vars/)
to specify backup points prefixed with `RSNAPSHOT_CONF_`:
```bash
# example
RSNAPSHOT_CONF_local1="backup /home/ localhost/"
RSNAPSHOT_CONF_local2="backup /etc/ localhost/"
RSNAPSHOT_CONF_local3="backup /usr/local/ localhost/"
RSNAPSHOT_CONF_pi="backup pi@192.168.1.101:/home/ 192.168.1.101/"
RSNAPSHOT_CONF_ex1="exclude media/movies"
RSNAPSHOT_CONF_ex2="exclude media/tv"
```
_avoid spaces except as a delimiter!_

3. use the `rsnapshot` [resin web terminal](https://docs.resin.io/learn/manage/ssh-access/#using-the-dashboard-web-terminal)
to adjust the schedules in `/etc/crontabs/root`:
```
# defaults:
alpha:	Every 4 hours
beta:	At 03:30 AM
gamma:	At 03:00 AM, only on Monday
delta:	At 02:30 AM, on day 1 of the month
```

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/resin-io-playground/cron-example
