#!/bin/bash
cd /opt/
wget -N http://211.103.207.119:81/keepalived/keepalived-1.3.4.tar.gz
tar xzf keepalived-1.3.4.tar.gz
cd keepalived-1.3.4
./configure --prefix=/usr/local/keepalived 
make
make install
cd /etc/init.d
wget -N http://211.103.207.119:81/keepalived/init/keepalived
chmod 755 keepalived
chkconfig --add keepalived
chkconfig keepalived on
cd /usr/local/keepalived/etc/sysconfig
wget -N http://211.103.207.119:81/keepalived/sysconfig/keepalived
cd /usr/local/keepalived/etc/keepalived
wget -N http://211.103.207.119:81/keepalived/keepalived.conf

