#!/bin/bash

rpm -ivh https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm

cat <<EOF
-------------num 1 install base package---------------------- 
EOF
yum install libgcrypt-devel lrzsz perl-DBI perl-libwww-perl net-snmp-perl  openssl-devel pcre-devel telnet  nfs-utils rpcbind -y

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

cat <<EOF
-------------num 2 stop iptables with selinux---------------
EOF
sed -i '7 c SELINUX=disabled' /etc/selinux/config
setenforce 0
systemctl stop firewalld
systemctl disable firewalld

cat <<EOF
------------num 3 install service--------------------------
EOF

yum update -y glibc*
yum update -y openssh
yum update -y bash
echo " export HISTTIMEFORMAT=\" %Y-%m-%d  %H:%M:%S  \`whoami\`  \" ">>/root/.bashrc
source /root/.bashrc
\. /root/.bashrc
[ ! -f /usr/sbin/ntpdate ] && yum install ntpdate -y
echo "*/5 * * * * /usr/sbin/ntpdate time1.aliyun.com >/dev/null 2>&1" >>/var/spool/cron/root

cat <<EOF
------------num 4 install saltstack client------------------------
EOF

cat <<EOF
congratulations on the success of your install !
EOF
