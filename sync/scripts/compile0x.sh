#!/bin/bash


tar -C /tmp -xf /vagrant/pe-latest.tar.gz
cd /tmp/puppet-enterprise-*
./puppet-enterprise-installer -a /vagrant/answerfiles/compile.txt
puppet config --section master set ca false
puppet config --section master set ca_server master.`hostname -d`
puppet config --section master set ca_port 8140

