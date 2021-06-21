#! /bin/sh
apt install libreadline-dev -y
tar -xzvf <(curl -Ls "https://ftp.postgresql.org/pub/source/v13.3/postgresql-13.3.tar.gz")
cd po*3
./configure
make
make install
if [ $(cat /etc/passwd | grep pgsql | wc -l) -eq 0 ]
then
  groupadd pgsql
  useradd -r -g pgsql pgsql
fi
mkdir /usr/local/pgsql/data
chown -R pgsql:pgsql /usr/local/pgsql/data
echo '[Unit]
Description=Pgsql
After=network.target

[Service]
Type=forking
User=pgsql
ExecStart=/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l /tmp/pgsql.log stop
PrivateTmp=false

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/pgsql.service
./initdb -D /usr/local/pgsql/data -U pgsql -W