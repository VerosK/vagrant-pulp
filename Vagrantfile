# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANT_REQUIRED_VERSION = "1.6.5"

# Require 1.6.5 at least
if ! defined? Vagrant.require_version
  if Gem::Version.new(Vagrant::VERSION) < Gem::Version.new(VAGRANT_REQUIRED_VERSION)
    puts "Vagrant >= " + VAGRANT_REQUIRED_VERSION + " required. Your version is " + Vagrant::VERSION
    exit 1
  end
else
  Vagrant.require_version ">= " + VAGRANT_REQUIRED_VERSION
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos-70-x64-vbox"
  config.vm.box_url = "vStone/centos-7.x-puppet.3.x"
  config.vm.hostname = "pulp.example.org"
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = ['modules']
    puppet.hiera_config_path = 'hiera_config.yaml'
#    puppet.working_directory = "/vagrant"
    puppet.options = "--verbose --pluginsync"
  end

  config.vm.provision :shell, :path => "setup-mirror.sh"

end

