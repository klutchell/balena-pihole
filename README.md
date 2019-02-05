# balena-pihole

If you're looking for a way to quickly and easily get up and running with a Pi-hole device for your home network, this is the project for you.

This project is a [balenaCloud](https://www.balena.io/cloud) stack with the following services:

* [Pi-hole](https://hub.docker.com/r/pihole/pihole/) (including [PADD](https://github.com/jpmck/PADD))
* [Unbound](https://nlnetlabs.nl/projects/unbound/about/)

balenaCloud is a free service to remotely manage and update your Raspberry Pi through an online dashboard interface, as well as providing remote access to the Pi-hole web interface without any additional configuation.

## Getting Started

To get started you'll first need to sign up for a free balenaCloud account and flash your device.

<https://www.balena.io/docs/learn/getting-started>

## Deployment

Once your account is set up, deployment is carried out by downloading the project and pushing it to your device either via Git or the balena CLI.

### Application Environment Variables

Application envionment variables apply to all services within the application, and can be applied fleet-wide to apply to multiple devices.

|Name|Value|Purpose|
|---|---|---|
|`TZ`|E.g. `America/Toronto`, find a [list of all timezone values here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).|To inform both `pihole` and `unbound` services of the timezone in your location, in order to set times and dates within the applications correctly.|

### Service Variables

Service variables are set to apply only to a specific service within the application, but can also be set to apply to all devices in the fleet.

|Service|Name|Value|Purpose|
|---|---|---|---|
|`pihole`|`DNS1`|`127.0.0.1#1053`|To tell Pi-hole where to forward DNS requests that aren’t blocked. We’re using the Unbound project here but you can specify your own.|
|`pihole`|`DNS2`|`127.0.0.1#1053`|Secondary DNS server - see above.|
|`pihole`|`DNSMASQ_LISTENING`|`eth0`|We set this to `eth0` to indicate we want DNSMASQ to listen on the ethernet interface of the Raspberry Pi. If you're connecting to your network replace this with `wlan0`|
|`pihole`|`INTERFACE`|`eth0`|As above|
|`pihole`|`IPv6`|`False`|We’re not using IPv6 internally here.|
|`pihole`|`ServerIP`|_[external device ip]_|Set this to the local IP address of your Pi-hole device to enable full ad-blocking. [Blocking modes are explained here](https://docs.pi-hole.net/ftldns/blockingmode/). `0.0.0.0` provides unspecified IP blocking.
|`pihole`|`WEBPASSWORD`|`mysecretpassword`|__Optional__ password for accessing the web-based interface of Pi-hole - you won’t be able to access the admin panel without defining a password here.

## Usage

<https://docs.pi-hole.net/guides/unbound/>

## Help

If you're having trouble getting the project running, submit an issue or post on the forums at <https://forums.balena.io>.

## Author

Kyle Harding <kylemharding@gmail.com>

## Acknowledgments

* <https://github.com/pi-hole/docker-pi-hole/>
* <https://docs.pi-hole.net/guides/unbound/>
* <https://github.com/folhabranca/docker-unbound>
* <https://github.com/MatthewVance/unbound-docker>
* <https://nlnetlabs.nl/documentation/unbound/howto-anchor/>
* <https://nlnetlabs.nl/documentation/unbound/howto-setup/>
* <http://www.linuxfromscratch.org/blfs/view/svn/server/unbound.html>

## License

[MIT License](./LICENSE)
