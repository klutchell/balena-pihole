# balena-pihole

If you're looking for a way to quickly and easily get up and running with a [Pi-hole](https://pi-hole.net/) device for your home network, this is the project for you.

This project is a [balenaCloud](https://www.balena.io/cloud) stack with the following services:

- [Pi-hole](https://pi-hole.net/)
- [PADD](https://github.com/pi-hole/PADD)
- [Unbound](https://unbound.net)

balenaCloud is a free service to remotely manage and update your Raspberry Pi through an online dashboard interface, as well as providing remote access to the Pi-hole web interface without any additional configuration.

## Hardware required

- Raspberry Pi 2/3/4 (Note: this project will not work with the Pi Zero), balenaFin, or NanoPi Neo Air
- 16GB Micro-SD Card (we recommend Sandisk Extreme Pro SD cards)
- Display (any Raspberry Pi display will work for this project)
- Micro-USB cable
- Power supply
- Case (optional)

## Getting Started

You can one-click-deploy this project to balena using the button below:

[![deploy button](https://balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/klutchell/balena-pihole&defaultDeviceType=raspberrypi3)

## Manual Deployment

Alternatively, deployment can be carried out by manually creating a [balenaCloud account](https://dashboard.balena-cloud.com) and application, flashing a device, downloading the project and pushing it via the [balena CLI](https://github.com/balena-io/balena-cli).

### Device Variables

Device Variables apply to all services within the application, and can be applied fleet-wide to apply to multiple devices. If you used the one-click-deploy method, the default environment variables will already be added for you to customize as needed.

| Name           | Default           | Purpose                                                                                                                                                            |
| -------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `TZ`           | `UTC`             | The timezone in your location. Find a [list of all timezone values here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).                            |
| `INTERFACE`    | `eth0`            | Provide the name of your device's primary network interface, usually `eth0` for wired or `wlan0` for wireless.                                                     |
| `WEBPASSWORD`  | `balena`          | Password for accessing the web-based interface of Pi-hole - you won’t be able to access the admin panel without defining a password here.                          |
| `PIHOLE_DNS_`  | `1.1.1.1;1.0.0.1` | Tell Pi-hole where to forward DNS requests that aren’t blocked. We’re using Cloudflare by default but you can specify your own using IPs delimited by semi-colons. |
| `SET_HOSTNAME` | `pihole`          | Set a custom device hostname on application start.                                                                                                                 |

## Usage

### Pi-hole

Check out our blog post on how to deploy network-wide ad-blocking with Pi-hole:

<https://www.balena.io/blog/deploy-network-wide-ad-blocking-with-pi-hole-and-a-raspberry-pi/>

Once your device joins the fleet you'll need to allow some time for it to download the application and download blocklists.

When it's done you should be able to access the access the app at <http://pihole.local> with a default password of `balena`.

On your router or DHCP server assign a static IP to your Pi-hole device, and set your clients DNS to the same IP address.

Documentation for Pi-hole can be found at <https://docs.pi-hole.net/>

### PADD

Note that this project uses the [fbcp block](https://github.com/balenablocks/fbcp).

The PiTFT LCD screens [from Adafruit (and others)](https://www.adafruit.com/?q=pitft) are supported.

In order to use these displays you're required to add additional configuration by setting
the `FBCP_DISPLAY` variable within the dashboard. This variable should be set to one of the values below:

- `adafruit-hx8357d-pitft`
- `adafruit-ili9341-pitft`
- `freeplaytech-waveshare32b`
- `waveshare35b-ili9486`
- `tontec-mz61581`
- `waveshare-st7789vw-hat`
- `waveshare-st7735s-hat`
- `kedei-v63-mpi3501`
- `dtoverlay` (requires `BALENA_HOST_CONFIG_dtoverlay` to be set)

#### Configuring HDMI and TFT display sizes

The following [Device Configuration](https://www.balena.io/docs/learn/manage/configuration/#configuration-variables)
variables might be required for proper scaling and resolutions:

| Name                                  | Value              |
| ------------------------------------- | ------------------ |
| BALENA_HOST_CONFIG_hdmi_cvt           | 480 320 60 1 0 0 0 |
| BALENA_HOST_CONFIG_hdmi_force_hotplug | 1                  |
| BALENA_HOST_CONFIG_hdmi_group         | 2                  |
| BALENA_HOST_CONFIG_hdmi_mode          | 87                 |
| BALENA_HOST_CONFIG_rotate_screen      | 1                  |

### Unbound

This project includes an Unbound service providing recursive DNS, but it is not used by default.

Read more about the reasons for using a recursive DNS with Pi-hole here:

<https://docs.pi-hole.net/guides/unbound/>

Set the following environment variable in your balenaCloud Dashboard to tell Pi-hole to forward DNS requests that aren’t blocked to the local Unbound DNS resolver service.

- `PIHOLE_DNS_`: `127.0.0.1#5053;127.0.0.1#5053`

**Note:** For security and footprint reasons, the Unbound container does not allow shell or terminal access via SSH or the balenaCloud console.

Advanced users can change the Unbound configuration by editing [`unbound.conf`](./unbound/unbound.conf) or [`a-records.conf`](./unbound/a-records.conf) before pushing the app to balenaCloud.

## Help

If you're having trouble getting the project running,
submit an issue or post on the forums at <https://forums.balena.io>.

## Contributing

Please open an issue or submit a pull request with any features, fixes, or changes.
