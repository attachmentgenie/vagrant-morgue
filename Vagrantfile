# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

###############################################################################
# Base box                                                                    #
###############################################################################
    config.vm.box = "puppetlabs/centos-6.6-64-puppet"

###############################################################################
# Global plugin settings                                                      #
###############################################################################
    plugins = ["vagrant-hostmanager"]
    plugins.each do |plugin|
      unless Vagrant.has_plugin?(plugin)
        raise plugin << " has not been installed."
      end
    end

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    # Configure cached packages to be shared between instances of the same base box.
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :machine
    end

###############################################################################
# Global provisioning settings                                                #
###############################################################################
    env = 'development'

###############################################################################
# Global VirtualBox settings                                                  #
###############################################################################
    config.vm.provider 'virtualbox' do |v|
    v.customize [
      'modifyvm', :id,
      '--groups', '/Vagrant/morgue'
    ]
    end

###############################################################################
# VM definitions                                                              #
###############################################################################
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.define :morgue do |morgue_config|
      morgue_config.vm.host_name = "morgue.testlab.vagrant"
      morgue_config.vm.network :private_network, ip: "192.168.50.130"
      morgue_config.vm.network :forwarded_port, guest: 22, host: 5030
      morgue_config.vm.synced_folder 'manifests/', "/etc/puppet/environments/#{env}/manifests"
      morgue_config.vm.synced_folder 'modules/', "/etc/puppet/environments/#{env}/modules"
      morgue_config.vm.synced_folder 'hiera/', '/var/lib/hiera'
      morgue_config.vm.synced_folder 'morgue/', '/var/www/morgue'
      morgue_config.vm.provision :puppet do |puppet|
          puppet.options           = "--environment #{env}"
          puppet.manifests_path    = "manifests"
          puppet.manifest_file     = ""
          puppet.module_path       = "modules"
          puppet.hiera_config_path = "hiera.yaml"
      end
    end
end