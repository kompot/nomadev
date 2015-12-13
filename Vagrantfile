# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
# Update apt and get dependencies
sudo apt-get update
sudo apt-get install -y unzip curl wget vim

# Download Nomad
echo Fetching Nomad...
cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/0.2.2/nomad_0.2.2_linux_amd64.zip -o nomad.zip

echo Installing Nomad...
unzip nomad.zip
sudo chmod +x nomad
sudo mv nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad
sudo chmod a+w /etc/nomad

SCRIPT

$nomadServer = <<SCRIPT
sudo stop nomad-server
sudo cp nomad-server.conf /etc/init/nomad-server.conf
sudo cp server.hcl /etc/nomad/server.hcl
sudo start nomad-server
SCRIPT

$nomadClient1 = <<SCRIPT
sudo stop nomad-client1
sudo cp nomad-client1.conf /etc/init/nomad-client1.conf
sudo cp client1.hcl /etc/nomad/client1.hcl
sudo start nomad-client1
SCRIPT

$nomadClient2 = <<SCRIPT
sudo stop nomad-client2
sudo cp nomad-client2.conf /etc/init/nomad-client2.conf
sudo cp client2.hcl /etc/nomad/client2.hcl
sudo start nomad-client2
SCRIPT

Vagrant.configure(2) do |config|
  #config.vm.box = "puphpet/ubuntu1404-x64"
  config.vm.box = "ubuntu/trusty64"

  config.vm.hostname = "nomad"
  config.vm.provision "shell", inline: $script, privileged: false
  config.vm.provision "docker" # Just install it
  config.vm.provision "file", source: "nomad-server.conf", destination: "nomad-server.conf"
  config.vm.provision "file", source: "nomad-client1.conf", destination: "nomad-client1.conf"
  config.vm.provision "file", source: "nomad-client2.conf", destination: "nomad-client2.conf"
  config.vm.provision "file", source: "server.hcl", destination: "server.hcl"
  config.vm.provision "file", source: "client1.hcl", destination: "client1.hcl"
  config.vm.provision "file", source: "client2.hcl", destination: "client2.hcl"
  config.vm.provision "shell", inline: $nomadServer, privileged: false
  config.vm.provision "shell", inline: $nomadClient1, privileged: false
  config.vm.provision "shell", inline: $nomadClient2, privileged: false
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 4646, host: 4640

  # Increase memory for Parallels Desktop
  config.vm.provider "parallels" do |p, o|
    p.memory = "1024"
  end

  # Increase memory for Virtualbox
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  # Increase memory for VMware
  ["vmware_fusion", "vmware_workstation"].each do |p|
    config.vm.provider p do |v|
      v.vmx["memsize"] = "1024"
    end
  end
end
