# CUPS Server in Docker on Synology Diskstation NAS for Brother printer HL-1110

Updating the info in [this blog post](http://www.theghostbit.com/2016/10/setting-up-cups-server-with-docker-on.html) to work with the printer model I have and an updated docker base image.

An overview of the steps are:

1) Install `Easy Bootstrap Installer` to install `ipkg` to allow installing utilities compiled for the NAS. Adding a new community source https://www.cphub.net to your Package Source under the Package Center settings.

2) SSH into the NAS and install `lsusb`

```bash
$ /opt/bin/ipkg install usbutils
```

3) Install `docker` on the NAS and download the updated `olbat/cupsd` base image

4) Edit the `setup.sh` script to fetch the drivers for the specific printer model. Copy the setup scripts to the NAS

```console
$ scp cups_start.sh admin@diskstation:/volume1/docker/cups/
$ scp setup.sh admin@diskstation:/volume1/docker/cups/
$ scp linux-brprinter-installer-2.2.0-1 admin@diskstation:/volume1/docker/cups/
```
