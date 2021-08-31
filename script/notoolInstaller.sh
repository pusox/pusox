#! /bin/sh
if [ -d "/usr/local/notool" ]
then
  echo 'PATH: /usr/local/notool exists, Exit.'
  exit
fi
echo -n 'TOKEN:'
read TOKEN
cd /usr/local
git clone https://oath2:$TOKEN@gitlab.byakko.icu/pusox/notool
if [ -d "/usr/local/notool" ]
then
  ln -s /usr/local/index.js /usr/local/bin/notool
  echo 'PATH="$PATH:/usr/local/notool/sh"' >> /etc/profile
  echo 'source /etc/profile'
  exit
fi
echo 'plz verify your token'