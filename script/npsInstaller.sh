#! /bin/sh
mkdir nps
cd nps
wget https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_amd64_server.tar.gz -O - | tar -xzvf -
cd ../
mv nps /usr/local/nps
UUID=$(cat /proc/sys/kernel/random/uuid)
echo 'appname = nps
runmode = dev

http_proxy_port=9080
https_proxy_port=9443
https_just_proxy=true
https_default_cert_file=conf/server.pem
https_default_key_file=conf/server.key

bridge_type=tcp
bridge_port=8024
bridge_ip=0.0.0.0

public_vkey=$UUID

log_level=7

web_username=admin
web_password=password
web_port=8023
web_ip=0.0.0.0
web_base_url=
web_open_ssl=false
web_cert_file=conf/server.pem
web_key_file=conf/server.key

auth_crypt_key =1234567812345678

allow_user_login=false
allow_user_register=false
allow_user_change_username=false
allow_flow_limit=false
allow_rate_limit=false
allow_tunnel_num_limit=false
allow_local_proxy=false
allow_connection_num_limit=false
allow_multi_ip=false
system_info_display=false

http_add_origin_header=false

disconnect_timeout=60' > /usr/local/nps/conf/nps.conf
echo '[Unit]
Description=nps service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/nps/nps
PrivateTmp=true

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/nps.service
systemctl enable nps
systemctl start nps
