#!/usr/bin/env bash

# Installers ici : http://www.ubuntu.com/download/alternative-downloads
DISTRO=xenial
#DISTRO=trusty
DISTRO_ARCH=i386
# DISTRO_ARCH=amd64

if [ -z "$HOST_ADDRESS" ]
then
  echo "HOST_ADDRESS doit être saisi pour créer l'installeur. Veuillez consulter INSTALL-VAGRANT.md !" >&2
  exit 1
fi

URL_PREFIX=http://archive.ubuntu.com/ubuntu/dists/
URL_SUFFIX=/current/images/netboot/mini.iso
SOURCE_ISO_URL=${URL_PREFIX}${DISTRO}-updates/main/installer-${DISTRO_ARCH}${URL_SUFFIX}
ISO_FILENAME=/vagrant/ubuntu-${DISTRO}-${DISTRO_ARCH}-installer.iso
CUSTOM_ISO_FILENAME=/vagrant/ubuntu-${DISTRO}-${DISTRO_ARCH}-installer-custom.iso

apt-get install -y mkisofs syslinux-utils

if [ ! -f $ISO_FILENAME ]
then
  echo "Downloading ${SOURCE_ISO_URL} -> ${ISO_FILENAME}..."
  wget -q -O $ISO_FILENAME $SOURCE_ISO_URL
else
  echo "${ISO_FILENAME} already exists, download skipped. Remove or rename it to download a new one."
fi

mkdir -p /mnt/iso
mount -o loop $ISO_FILENAME /mnt/iso

rm -rf /opt/ubuntu-installer
mkdir -p /opt/ubuntu-installer
cp -rT /mnt/iso /opt/ubuntu-installer

umount /mnt/iso

#cp /vagrant/ks.cfg /opt/ubuntu-installer/ks.cfg
cp /vagrant/preseed.cfg /opt/ubuntu-installer/preseed.cfg

# Replace txt.cfg with our custom one and backup original one.
rm -f /vagrant/txt.cfg.orig
cp /opt/ubuntu-installer/txt.cfg /vagrant/txt.cfg.orig

cat >/opt/ubuntu-installer/txt.cfg << EOT
default auto
label auto
	menu label ^Effacer et installer
	menu default
	kernel linux
	append vga=788 initrd=initrd.gz preseed/url=http://$HOST_ADDRESS:8080/preseed.cfg hostname=ubuntu domain=local auto=true --- quiet
	text help
   Installe automatiquement $DISTRO-$DISTRO_ARCH depuis http://$HOST_ADDRESS:8080
	endtext
EOT

chmod -w /opt/ubuntu-installer/txt.cfg

rm -f /vagrant/menu.cfg.orig
cp /opt/ubuntu-installer/menu.cfg /vagrant/menu.cfg.orig
cp /vagrant/menu.cfg /opt/ubuntu-installer/menu.cfg
chmod -w /opt/ubuntu-installer/menu.cfg

cd /opt/ubuntu-installer/
mkisofs -D -r -V "ATTENDLESS_UBUNTU" -cache-inodes -J -l -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $CUSTOM_ISO_FILENAME /opt/ubuntu-installer
isohybrid $CUSTOM_ISO_FILENAME

#mkisofs -D -r -V "ATTENDLESS_UBUNTU" -cache-inodes -J -l -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o /vagrant/custom.iso /opt/ubuntu-installer
