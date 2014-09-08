#!/bin/bash

yum install -qy haproxy
cp /vagrant/files/haproxy.cfg /etc/haproxy/
chkconfig haproxy on
service haproxy start

