#! /bin/bash
wget "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian10-4.4.6.tgz"
apt update
apt -y install libcurl4 openssl
tar -zvxf mongo*
rm *tgz
mv mongodb*  /usr/local/mongodb
echo /###############
echo 
echo "add group and user"
echo 
echo /###############
echo 
if [ $(cat /etc/passwd | grep mongodb | wc -l) -eq 0 ]
then
  groupadd mongodb
  useradd -r -g mongodb mongodb
fi
mkdir -p /usr/local/mongodb/db
mkdir -p /usr/local/mongodb/log
chown mongodb:mongodb /usr/local/mongodb/db
chown mongodb:mongodb /usr/local/mongodb/log
echo "add service for mongodb"
echo '[Unit]
Description=mongodb
After=network.target

[Service]
Type=forking
User=mongodb
ExecStart=/usr/local/mongodb/mongod --dbpath /usr/local/mongodb/db --logpath /usr/local/mongodb/log/mongod.log --fork
ExecStop=/usr/local/mongodb/mongod --dbpath /usr/local/mongodb/db --logpath /usr/local/mongodb/log/mongod.log --shutdown
PrivateTmp=false

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/mongodb.service
sudo systemctl enable mongodb
sudo systemctl start mongodb
echo 
echo Congratuations!
echo
echo Tuzi