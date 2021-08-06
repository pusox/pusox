#! /bin/sh
mkdir /boot/newinstall
if [ $(arch) = 'aarch64' ]
then
  arch='arm64'
elif [ $(arch) = 'x86_64' ]
then
  arch='amd64'
fi
wget "http://ftp.debian.org/debian/dists/buster/main/installer-$arch/current/images/netboot/debian-installer/$arch/initrd.gz" -O /boot/newinstall/initrd.gz
wget "http://ftp.debian.org/debian/dists/buster/main/installer-$arch/current/images/netboot/debian-installer/$arch/linux" -O /boot/newinstall/linux
echo "menuentry 'New Install' {
insmod part_msdos
insmod ext2
set root='(hd0,msdos1)'
linux /boot/newinstall/linux
initrd /boot/newinstall/initrd.gz
}"
