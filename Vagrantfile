Vagrant.configure('2') do |config|
  ### Linux
  # config.vm.box = 'ubuntu/xenial64'
  config.vm.box = 'ybart/ubuntu-xenial-i386'

  config.vm.synced_folder '.', "/vagrant"

  config.vm.provider 'virtualbox' do |v|
    v.name = "Women on Rails"
  end

  ### ZSH, RVM, Ruby & Rails
  config.vm.provision :shell, path: 'vagrant/install-packages.sh', privileged: true
  config.vm.provision :shell, path: 'vagrant/install-oh-my-zsh.sh', privileged: false
  config.vm.provision :shell, path: 'vagrant/install-rvm.sh', args: 'stable', privileged: false
  config.vm.provision :shell, path: 'vagrant/install-ruby.sh', args: '2.3.1 rails:4.2.5.1',
                              privileged: false
  config.vm.provision :shell, path: 'vagrant/install-wor.sh', privileged: false

  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  ## GUI
  # config.vm.provision :shell, path: 'vagrant/install-xubuntu.sh', args: 'stable', privileged: true
  # config.vm.provision :shell, path: 'vagrant/install-gui-settings.sh', privileged: false
end
