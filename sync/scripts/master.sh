#!/bin/bash

tar -C /tmp -xf /vagrant/pe-latest.tar.gz
cd /tmp/puppet-enterprise-*
./puppet-enterprise-installer -a /vagrant/answerfiles/all-in-one.txt
puppet config --section master set environmentpath  '$confdir/environments'
puppet config --section master set default_manifest '$confdir/manifests'
puppet config --section master set basemodulepath '$confdir/modules:/opt/puppet/share/puppet/modules'

puppet module install puppetlabs-vcsrepo
puppet module install jfryman-nginx
puppet module install puppetlabs-ntp --ignore-dependencies

mkdir -p /etc/puppetlabs/puppet/environments/production
git clone https://github.com/fvoges/puppet-demo.git /etc/puppetlabs/puppet/environments/production


