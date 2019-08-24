#!/bin/bash
#检查是否安装依赖包.并下载php-fpm , mariadb.

rpm -q gcc pcre-devel openssl-devel || yum -y install gcc pcre-devel openssl-devel
pm -q php php-fpm php mariadb mariadb-server mariadb-devel || yum -y install  php php-fpm php mariadb mariadb-server mariadb-devel 

cd /root/

#nginx 包源码安装,并启动

[  -f nginx-1.12.2.tar.gz ]
if [ $? -eq 0 ];
then
	echo"文件存在"	
	tar -xvf nginx-1.12.2.tar.gz >& /var/null
	cd nginx-1.12.2
	./configure --with-http_ssl_module
	make && make install
	/usr/local/nginx/sbin/nginx
	ln -s /usr/local/nginx/sbin/nginx /sb/
else
echo "文件不存在"
exit
fi


systemctl start php-fpm
systemctl enable php-fpm
systemctl start mariadb
systemctl enable mariadb

#修改nginx配置,使其支持php web访问

sed -i "65,71s/#//" /usr/local/nginx/conf/nginx.conf
sed -i "s/fastcgi_params/fastcgi.conf/" /usr/local/nginx/conf/nginx.conf
sed -i "69d" /usr/local/nginx/conf/nginx.conf
