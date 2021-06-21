#! /bin/sh
mkdir /boot/newinstall
wget "http://mirrors.cloud.tencent.com/debian/dists/buster/main/installer-amd64/current/images/netboot/debian-installer/amd64/initrd.gz" -O /boot/newinstall/initrd.gz
wget "http://mirrors.cloud.tencent.com/debian/dists/buster/main/installer-amd64/current/images/netboot/debian-installer/amd64/linux" -O /boot/newinstall/linux
echo "menuentry 'New Install' {
insmod part_msdos
insmod ext2
set root='(hd0,msdos1)'
linux /boot/newinstall/linux
initrd /boot/newinstall/initrd.gz
}"