# vim: set ft=ruby :

Vagrant.require_version '>= 1.7.4'

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  #config.vm.network 'public_network', bridge: 'en0: Wi-Fi (AirPort)'


  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
  end

  config.ssh.forward_agent = true

  config.vm.define 'consul' do |v|
    v.ssh.port = 2210
    v.vm.network 'forwarded_port', guest: 22, host: 2210

    v.vm.hostname = 'consul'
    v.vm.network 'private_network', ip: '192.168.10.10'
    v.vm.network 'forwarded_port', guest: 80, host: 8080
  end

  config.vm.define 'client1' do |v|
    v.ssh.port = 2220
    v.vm.network 'forwarded_port', guest: 22, host: 2220

    v.vm.hostname = 'client1'
    v.vm.network 'private_network', ip: '192.168.10.20'
  end

  config.vm.define 'client2' do |v|
    v.ssh.port = 2230
    v.vm.network 'forwarded_port', guest: 22, host: 2230

    v.vm.hostname = 'client1'
    v.vm.network 'private_network', ip: '192.168.10.30'
  end

  config.vm.provision 'ansible' do |ansible|
    # ansible.verbose = 'vv'
    ansible.playbook = 'ansible/nomadev.yml'
    ansible.inventory_path = 'hosts'
    ansible.sudo = true
  end

end
