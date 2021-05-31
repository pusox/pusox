#! /bin/bash
#! https://github.com/Debuffxb/Some_Shell
wget "https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/MySQL-5.7/mysql-5.7.33-linux-glibc2.12-x86_64.tar.gz"
sudo apt -y install libaio-dev libnuma-dev libncurses5
tar -zvxf mysql*
rm *gz*
mv mysql* /usr/local/mysql
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
