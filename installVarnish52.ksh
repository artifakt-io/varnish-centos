#!/bin/sh
rpm -ivh --replacepkgs jemalloc-3.6.0-1.el6/jemalloc-3.6.0-1.el6.x86_64.rpm
./script.rpm.sh
yum-config-manager --enable epel
yum install varnish --disablerepo=amzn-updates --disablerepo=amzn-main --disablerepo=epel -y
chkconfig varnish on
sed -e 's/VARNISH_LISTEN_PORT\=6081/VARNISH_LISTEN_PORT\=80/' -i /etc/sysconfig/varnish
vhost=$(ls /etc/nginx/sites-enabled/)
cd /etc/nginx/sites-enabled
sed -e 's/listen.*.80\;/listen 8080;/' -i $vhost
