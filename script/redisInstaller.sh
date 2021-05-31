#! /bin/sh
wget https://download.redis.io/releases/redis-6.2.3.tar.gz
tar xzf redis-6.2.3.tar.gz
cd redis-6.2.3
make
make install
echo '[Unit]
Description=Redis service
After=network.target
[Service]
Type=simple
ExecStart=/usr/local/bin/redis-server
PrivateTmp=true
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/redis.service
systemctl start redis
systemctl enable redis
cd ../
rm redis-6.2.3* -r
