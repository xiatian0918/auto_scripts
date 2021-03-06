#!/bin/sh
#install rabitmq
#author:xiatian

yum install erlang  -y
wget http://192.168.0.62/tools/rabbitmq-server-3.6.6-1.el7.noarch.rpm
yum install rabbitmq-server-3.6.6-1.el7.noarch.rpm  -y
service rabbitmq-server start
service rabbitmq-server status

find / -name "rabbitmq.config.example"
cp /usr/share/doc/rabbitmq-server-3.6.6/rabbitmq.config.example /etc/rabbitmq/
cd /etc/rabbitmq/
cp rabbitmq.config.example rabbitmq.config
rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server restart
rabbitmqctl add_user toprs 123456789
rabbitmqctl set_user_tags toprs administrator
rabbitmqctl set_permissions -p "/" toprs ".*" ".*" ".*"
rabbitmqctl list_users
netstat -tlnp|grep 15672
