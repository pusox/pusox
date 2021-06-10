#! /bin/sh
wget https://github.com/fatedier/frp/releases/download/v0.25.3/frp_0.25.3_linux_amd64.tar.gz -O - | tar -xzvf -
rm frp*/frpc*
mv frp* /usr/local/frps
echo '[common]
token = token
bind_port = 7000
vhost_http_port = 6001' > /usr/local/frps/frps.ini
echo '[Unit]
Description=frps service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/frps/frps -c /usr/local/frps/frps.ini
PrivateTmp=true

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/frps.service
systemctl enable frps
systemctl start frps
