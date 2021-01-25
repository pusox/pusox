apt install sudo make -y
sudo apt update && sudo apt install -y libssl-dev zlib1g zlib1g-dev libpcre3 libpcre3-dev
wget http://aventador.debuffxb.com/file/nginx-1.16.0.tar.gz
tar -xzvf nginx-1.16.0.tar.gz
cd nginx-1.16.0
./configure --with-http_ssl_module && make && sudo make install
echo '[Unit]
Description=nginx service
After=network.target
[Service]
Type=forking
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s quit
PrivateTmp=true
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/nginx.service
mkdir /usr/local/nginx/conf/vhost
echo 'server {
  listen 80;
  server_name _;
  return 444;
}'>/usr/local/nginx/conf/vhost/default.conf
service nginx restart