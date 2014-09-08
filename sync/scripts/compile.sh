#!/bin/bash

yum install -q -y haproxy
cp /vagrant/files/haproxy.cfg /etc/haproxy/
chkconfig haproxy on
service haproxy start

