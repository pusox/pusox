#! /bin/sh
if [ -d "/usr/local/node_exporter" ]
then
  echo 'PATH: /usr/local/node_exporter exists, Exit.'
  exit
fi
if [ $(arch) = 'aarch64' ]
then
  arch='arm64'
elif [ $(arch) = 'x86_64' ]
then
  arch='amd64'
fi
wget "https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-$arch.tar.gz" -O- | tar -xzvf -
mv node_exporter* /usr/local/node_exporter
echo '[Unit]
Description=node_export
Documentation=https://github.com/prometheus/node_exporter
After=network.target
 
[Service]
Type=simple
ExecStart=/usr/local/node_exporter/node_exporter --web.listen-address=":9200"
Restart=on-failure
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/node_exporter.service
systemctl enable node_exporter
systemctl start node_exporter
