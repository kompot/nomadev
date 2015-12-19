# -*- mode: ruby -*-
# vi: set ft=ruby :

$base = <<SCRIPT
sudo apt-get install -y unzip curl wget vim
SCRIPT

$nomad = <<SCRIPT
echo Fetching Nomad
cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/0.2.3/nomad_0.2.3_linux_amd64.zip -o nomad.zip

echo Installing Nomad
unzip -o nomad.zip
sudo chmod +x nomad
sudo mv nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad
sudo chmod a+w /etc/nomad

SCRIPT


$consul = <<SCRIPT
echo Fetching Consul
cd /tmp/
curl -sSL https://releases.hashicorp.com/consul/0.6.0/consul_0.6.0_linux_amd64.zip -o consul.zip
echo Installing Consul
unzip -o consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul
SCRIPT

$consulServer = <<SCRIPT
echo Fetching Consul UI
sudo mkdir -p /tmp/consul/ui
cd /tmp/consul/ui
sudo curl -sSL https://releases.hashicorp.com/consul/0.6.0/consul_0.6.0_web_ui.zip -o ui.zip
sudo unzip -o ui.zip
cd
sudo stop consul-server
sudo cp consul-server.conf /etc/init/consul-server.conf
sudo start consul-server
SCRIPT

$consulClient1 = <<SCRIPT
sudo stop consul-client
sudo cp consul-client1.conf /etc/init/consul-client.conf
sudo start consul-client
SCRIPT

$consulClient2 = <<SCRIPT
sudo stop consul-client
sudo cp consul-client2.conf /etc/init/consul-client.conf
sudo start consul-client
SCRIPT

$nomadServer = <<SCRIPT
sudo stop nomad-server
sudo cp nomad-server.conf /etc/init/nomad-server.conf
sudo cp server.hcl /etc/nomad/server.hcl
sudo start nomad-server
SCRIPT

$nomadClient1 = <<SCRIPT
sudo stop nomad-client
sudo cp nomad-client1.conf /etc/init/nomad-client.conf
sudo cp client1.hcl /etc/nomad/client.hcl
sudo start nomad-client
SCRIPT

$nomadClient2 = <<SCRIPT
sudo stop nomad-client
sudo cp nomad-client2.conf /etc/init/nomad-client.conf
sudo cp client2.hcl /etc/nomad/client.hcl
sudo start nomad-client
SCRIPT

Vagrant.configure(2) do |config|
  #config.vm.box = 'puphpet/ubuntu1404-x64'
  config.vm.box = 'ubuntu/trusty64'

  # Increase memory for Parallels Desktop
  # config.vm.provider 'parallels' do |p, o|
  #   p.memory = '4096'
  # end

  # Increase memory for Virtualbox
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
  end

  # Increase memory for VMware
  # ['vmware_fusion', 'vmware_workstation'].each do |p|
  #   config.vm.provider p do |v|
  #     v.vmx['memsize'] = '4096'
  #   end
  # end

  config.vm.define 'consul-server' do |v|
    v.vm.hostname = 'consul-server'
    v.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "10.0.1.10"

    v.vm.provision 'shell', inline: $base, privileged: false
    v.vm.provision 'shell', inline: $consul, privileged: false
    v.vm.provision 'file', source: 'consul-server.conf', destination: 'consul-server.conf'
    v.vm.provision 'shell', inline: $consulServer, privileged: false
  end

  config.vm.define 'nomad-server' do |v|
    v.vm.hostname = 'nomad-server'
    v.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "10.0.1.11"
    v.vm.network 'forwarded_port', guest: 4646, host: 4640

    v.vm.provision 'shell', inline: $base, privileged: false
    v.vm.provision 'shell', inline: $nomad, privileged: false
    v.vm.provision 'file', source: 'server.hcl', destination: 'server.hcl'
    v.vm.provision 'file', source: 'nomad-server.conf', destination: 'nomad-server.conf'
    v.vm.provision 'shell', inline: $nomadServer, privileged: false
  end

  config.vm.define 'client1' do |v|
    v.vm.hostname = 'client1'
    v.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "10.0.1.12"

    v.vm.provision 'docker'
    v.vm.provision 'shell', inline: $base, privileged: false

    v.vm.provision 'shell', inline: $consul, privileged: false
    v.vm.provision 'file', source: 'consul-client1.conf', destination: 'consul-client1.conf'
    v.vm.provision 'shell', inline: $consulClient1, privileged: false

    v.vm.provision 'shell', inline: $nomad, privileged: false
    v.vm.provision 'file', source: 'client1.hcl', destination: 'client1.hcl'
    v.vm.provision 'file', source: 'nomad-client1.conf', destination: 'nomad-client1.conf'
    v.vm.provision 'shell', inline: $nomadClient1, privileged: false
  end

  config.vm.define 'client2' do |v|
    v.vm.hostname = 'client2'
    v.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "10.0.1.13"

    v.vm.provision 'docker'
    v.vm.provision 'shell', inline: $base, privileged: false

    v.vm.provision 'shell', inline: $consul, privileged: false
    v.vm.provision 'file', source: 'consul-client2.conf', destination: 'consul-client2.conf'
    v.vm.provision 'shell', inline: $consulClient2, privileged: false

    v.vm.provision 'shell', inline: $nomad, privileged: false
    v.vm.provision 'file', source: 'client2.hcl', destination: 'client2.hcl'
    v.vm.provision 'file', source: 'nomad-client2.conf', destination: 'nomad-client2.conf'
    v.vm.provision 'shell', inline: $nomadClient2, privileged: false
  end

end
