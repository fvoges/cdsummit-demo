#!/bin/bash

yum install -qy vim-enhanced bash-completion ccze colordiff curl git htop lftp lynx mc mutt psmisc rsync sysstat telnet wget mercurial tree avahi avahi-tools nss-mdns

/vagrant/scripts/rcfiles.sh
sudo -nu vagrant -i /vagrant/scripts/rcfiles.sh

service iptables stop
chkconfig iptables off
service avahi-daemon start
chkconfig avahi-daemon on


