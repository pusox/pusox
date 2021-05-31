#! /bin/bash
wget "https://downloads.mysql.com/archives/get/p/23/file/mysql-boost-5.7.33.tar.gz"
sudo apt -y install libncurses5-dev gcc g++ cmake pkg-config
tar -zvxf mysql*
rm *gz
cd mysql*
sed -i 's/char buf\[TC_BUFSIZE\];//' cmd-line-utils/libedit/libedit-20190324-3.1/src/terminal.c
sed -i 's/area = buf/area = NULL/' cmd-line-utils/libedit/libedit-20190324-3.1/src/terminal.c
cmake . -DWITH_BOOST=boost/boost_1_59_0
make -j$(nproc)
make install
echo /###############
echo 
echo "add group and user"
echo 
echo /###############
echo 
if [ $(cat /etc/passwd | grep mysql | wc -l) -eq 0 ]
then
  groupadd mysql
  useradd -r -g mysql mysql
fi
/usr/local/mysql/bin/mysqld --initialize --user=mysql
/usr/local/mysql/bin/mysql_ssl_rsa_setup
ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
echo "add service for mysql"
echo '[Unit]
Description=Mysql
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/mysql/support-files/mysql.server start
ExecReload=/usr/local/mysql/support-files/mysql.server restart
ExecStop=/usr/local/mysql/support-files/mysql.server stop
PrivateTmp=false

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/mysql.service
sudo systemctl enable mysql
sudo systemctl start mysql
echo 
echo Congratuations!
echo
echo Tuzi
echo 
echo "mysql -uroot -p"
echo "set password for root@localhost = password('')"
echo 
