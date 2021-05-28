#! /bin/sh
if [ -d "/usr/local/node" ]
then
  echo 'PATH: /usr/local/node exists, Exit.'
  exit
fi
if [ $(arch) = 'aarch64' ]
then
  arch='arm64'
elif [ $(arch) = 'x86_64' ]
then
  arch='x64'
fi
wget "https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-$arch.tar.xz" -O- | tar -xJvf -
mv node* /usr/local/node
echo 'PATH="$PATH:/usr/local/node/bin"' >> /etc/profile
echo 'source /etc/profile'
