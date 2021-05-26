#! /bin/bash
#! https://github.com/Debuffxb/Some_Shell
sudo apt update && sudo apt upgrade
sudo apt install libxslt1-dev libfreetype6-dev freetype2-demos libpng* openssl libssl-dev libxml2-dev libxml2 libzip-dev libcurl4-gnutls-dev libjpeg-dev -y
ln -s /usr/include/$(arch)-linux-gnu/curl /usr/include/curl
wget "https://downloads.sourceforge.net/freetype/freetype-2.10.4.tar.xz"
tar -xvf freetype-2.10.4.tar.xz
cd free*4
sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&
sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&
./configure --prefix=/usr --enable-freetype-config --disable-static &&
make && make install
cd ../
wget "https://www.php.net/distributions/php-7.3.27.tar.gz"
tar -xzvf php-7.3.27.tar.gz
rm php*gz
cd php-7.3.27
./configure --prefix=/usr/local/php --with-curl --with-freetype-dir --with-gd --with-gettext --with-iconv-dir --with-kerberos --with-libxml-dir --with-jpeg-dir --with-mysqli --with-openssl --with-pcre-regex --with-pdo-mysql --with-pdo-sqlite --with-pear --with-png-dir --with-xmlrpc --with-xsl --with-zlib --enable-fpm --enable-bcmath --enable-libxml --enable-inline-optimization --enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl --enable-shmop --enable-soap --enable-sockets --enable-sysvsem --enable-xml --with-libdir=lib/$(arch)-linux-gnu --enable-zip && make && sudo make install
groupadd php-fpm
useradd -r -g php-fpm php-fpm
chown -R php-fpm:php-fpm /usr/local/php/var
echo
echo "Write service file"
sleep 5
echo "[Unit]
Description=php-fpm service
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/php/sbin/php-fpm
User=php-fpm
Group=php-fpm
ExecReload=kill -USR2 'cat /usr/local/php/var/run/php-fpm.pid'
ExecStop=kill -INT 'cat /usr/local/php/var/run/php-fpm.pid'
PrivateTmp=true

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/php-fpm.service
echo
echo "Write some Configuration files"
sleep 5
cd ../
rm -r php-7.3.27
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
sed -i 's/nobody/php-fpm/g' /usr/local/php/etc/php-fpm.d/www.conf
echo
echo "Enable service of php-fpm"
sudo systemctl enable php-fpm
sudo systemctl start php-fpm
echo /###############
echo 
echo 
echo Congratuations!
echo 
echo Tuzi
echo 
