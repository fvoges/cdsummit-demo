# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

domain = 'puppetlabs.vm'

boxes = [
  {
    :name           =>  'master',
    :primary        =>  'true',
    :cpus           =>  '2',
    :mem            =>  '4096',
    :extra_script   =>  '/vagrant/scripts/master.sh'
  },
#  {
#    :name           =>  'compile01',
#    :primary        =>  'false',
#    :cpus           =>  '2',
#    :mem            =>  '2048',
#    :extra_script   =>  '/vagrant/scripts/compile0x.sh'
#  },
#  {
#    :name           =>  'compile02',
#    :primary        =>  'false',
#    :cpus           =>  '2',
#    :mem            =>  '2048',
#    :extra_script   =>  '/vagrant/scripts/compile0x.sh'
#  },
#  {
#    :name           =>  'compile',
#    :primary        =>  'false',
#    :extra_script   =>  '/vagrant/scripts/compile.sh'
#  },
  {
    :name           =>  'agent01',
    :primary        =>  'false',
    :extra_script   =>  '/vagrant/scripts/agent.sh'
  },

]

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
BOX_TIMEOUT             = 300


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  boxes.each do |box|
    config.hostmanager.enabled            = false
    config.hostmanager.manage_host        = false
    config.hostmanager.ignore_private_ip  = false
    config.hostmanager.include_offline    = false

    config.vm.define box[:name], primary: box[:primary] do |node|
      node.vm.box                 = 'puppetlabs/centos-6.5-64-puppet'
      node.vm.hostname            = box[:name] + "." + domain

      node.vm.boot_timeout        = BOX_TIMEOUT
      node.vm.synced_folder '.', '/vagrant', :disabled => true
      node.vm.synced_folder 'sync', '/vagrant', :type => 'rsync'

      config.vm.provider "vmware_fusion" do |v|
        if box[:cpus]
          v.vmx["numvcpus"] = box[:cpus]
        end
        if box[:mem]
          v.vmx["memsize"] = box[:mem]
        end
      end
      # We want to setup /etc/hosts with the private IPs
#      node.hostmanager.ip_resolver = proc do |vm, resolving_vm|
#        box[:private_ip]
#      end
      node.hostmanager.aliases      = [ box[:name] ]

#      node.vm.provision :shell, :privileged => false, :inline => "sudo cp -f /vagrant/etc-setup/etc-resolv-conf /etc/resolv.conf"
#      node.vm.provision :shell, :privileged => false, :inline => "cp /vagrant/ssh-setup/config /home/ec2-user/.ssh/"
#      node.vm.provision :shell, :privileged => false, :inline => "cp /vagrant/ssh-setup/RHEL-OSE-DEMO.pem /home/ec2-user/.ssh/"
#      node.vm.provision :shell, :privileged => false, :inline => "sudo yum -y -q update"
      node.vm.provision :shell, :privileged => false, :inline => "sudo yum -y -q install screen"

      node.vm.provision :shell, :privileged => true, :inline => '/vagrant/scripts/provision.sh'
      node.vm.provision :hostmanager

      if box[:extra_script]
        node.vm.provision :shell, :privileged => true, :inline => box[:extra_script]
      end

      node.ssh.pty                  = false
    end
  end
end
