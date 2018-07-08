#!/bin/sh

echo "Running apt-get update/upgrade..."
apt-get update

echo "Installing Brother install requirements..."
apt-get install lib32gcc1 libc6-i386 lib32stdc++6 -y

echo "Running Brother printer setup..."
printf 'y\nn\nn\n' | /home/print/linux-brprinter-installer-2.2.0-1 HL-1110

echo "Enabling printer sharing for CUPS..."
cupsctl --share-printers
cupsctl --remote-admin

## Avahi wasn't needed with this base image it seems
# echo "Installing Avahi..."
# DEBIAN_FRONTEND=noninteractive apt-get install avahi-daemon -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

# echo "Starting Avahi..."
# /etc/init.d/avahi-daemon start