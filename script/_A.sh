#! /bin/bash
vimCompatible=$(cat /etc/vim/vimrc.tiny | grep nocompatible | wc -l)
ClientAliveInterval=$(cat /etc/ssh/sshd_config | grep 'ClientAliveInterval 30' | wc -l)
if [ $vimCompatible -eq 0 ]; then
  echo 'Set Vim Config';
  sed -i "s/compatible/nocompatible/g" /etc/vim/vimrc.tiny
  echo 'set backspace=2' >> /etc/vim/vimrc.tiny
  echo 'set ts=2' >> /etc/vim/vimrc.tiny
  echo 'set expandtab' >> /etc/vim/vimrc.tiny
  echo 'set encoding=utf8' >> /etc/vim/vimrc.tiny
  echo 'set fileencoding=utf8' >> /etc/vim/vimrc.tiny
fi
if [ $ClientAliveInterval -eq 0 ]; then
  echo 'Set SSH Alive Interval'
  echo 'ClientAliveInterval 30' >> /etc/ssh/sshd_config
  echo 'ClientAliveCountMax 86400' >> /etc/ssh/sshd_config
  service sshd restart
fi
apt update
apt -y upgrade
apt install -y git gcc htop screen net-tools sysstat sudo dnsutils make ethtool iftop iptables
