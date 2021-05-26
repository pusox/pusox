#! /bin/sh
apt install autoconf
wget "https://github.com/phpredis/phpredis/archive/refs/tags/5.3.4.tar.gz"
tar -xzvf 5.3.4.tar.gz
cd phpredis-5.3.4
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
echo 'extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20180731/"
extension=redis.so' >> /usr/local/php/lib/php.ini
service php-fpm status