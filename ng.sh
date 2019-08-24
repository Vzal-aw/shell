#!/bin/bash
#检查是否安装依赖包
rpm -q gcc pcre-devel openssl-devel || yum -y install gcc pcre-devel openssl-devel
cd /root/	
tar -xvf nginx-1.12.2.tar.gz >& /var/null
cd nginx-1.12.2
./configure --with-http_ssl_module
make && make install
/usr/local/nginx/sbin/nginx
ln -s /usr/local/nginx/sbin/nginx /sbin/

