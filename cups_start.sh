#!/bin/sh

# Stop CUPSD if it is running
echo "Stopping cupsd on Synology..."
/usr/syno/sbin/synoservicecfg --hard-stop cupsd

# Get Printer location
echo "Getting printer info..."
BUS=$(/opt/sbin/lsusb|grep Brother|awk '{print $2}')
DEV=$(/opt/sbin/lsusb|grep Brother|awk '{print $4}')
DEV="${DEV%?}"
PRINTER="/dev/bus/usb/$BUS/$DEV"

# Stop Container
echo "Stopping current container..."
/usr/local/bin/docker kill cups-server
/usr/local/bin/docker rm cups-server

# Run Docker
echo "Running container..."
containerID=$(docker run -d -p 631:631 -p 5353:5353 -v /volume1/docker/cups/:/home/print -v /var/run/dbus:/var/run/dbus --privileged=true --device=$PRINTER --name cups-server --net=host olbat/cupsd)

# Run Setup script
echo "Executing container setup script..."
/usr/local/bin/docker exec $containerID /bin/sh -c "/home/print/setup.sh" &

echo "Done!"

exit 0
