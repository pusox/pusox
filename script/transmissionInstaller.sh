apt install sudo make -y
sudo apt update && sudo apt install -y gcc libcurl4-openssl-dev pkg-config libevent-dev zlib1g-dev openssl libssl-dev intltool g++

wget "https://github.com/transmission/transmission-releases/raw/master/transmission-3.00.tar.xz" -O- | tar -xJvf -
cd transmi*
./configure --prefix=/usr/local/transmission
make && make install
if [ $(cat /etc/passwd | grep transmission | wc -l) -eq 0 ]
then
  groupadd transmission
  useradd -r -g transmission transmission
fi
echo '[Unit]
Description=transmission service
After=network.target
[Service]
User=transmission
Group=transmission
Type=forking
ExecStart=/usr/local/transmission/bin/transmission-daemon
PrivateTmp=true
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/transmission.service
