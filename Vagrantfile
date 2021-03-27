# -*- mode: ruby -*-
# vi: set ft=ruby :

# Every Vagrant development environment requires a box. You can search for
# boxes at https://atlas.hashicorp.com/search.
BOX_IMAGE = "centos/7"

Vagrant.configure("2") do |config|

  config.vm.define "webserver01" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "webserver01"
    subconfig.vm.network :private_network, ip: "192.168.121.11"
    subconfig.vm.network :forwarded_port, guest: 80, host: 8080
    subconfig.vm.provision "shell", path: "webserver/webserver.sh"
    #subconfig.vm.provision "shell", path: "prometheus/node_exporter.sh"
    subconfig.vm.provision "ansible" do |ansible|
        ansible.playbook = "webserver/webserver.yml"
    end
    subconfig.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end
  end

  config.vm.define "mysql01" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "mysql01"
    subconfig.vm.network :private_network, ip: "192.168.121.12"
    subconfig.vm.provision "shell", path: "prometheus/node_exporter.sh"
    subconfig.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
      end
    end

  config.vm.define "mysql02" do |subconfig| 
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "mysql02"
    subconfig.vm.network :private_network, ip: "192.168.121.13"
    subconfig.vm.provision "shell", path: "prometheus/node_exporter.sh"
    subconfig.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
      end
  end
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "mysql/install_sqlserver.yml"
  end
  #config.vm.provision do |shell|
  #  shell.vm.provision "shell", path: "prometheus/node_exporter.sh"
  #end
  
  config.vm.define "prometheus01" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "prometheus01"
    subconfig.vm.network :private_network, ip: "192.168.121.14"
    subconfig.vm.network :forwarded_port, guest: 9090, host: 9090
    subconfig.vm.provision "shell", path: "prometheus/prometheus.sh"
    subconfig.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
      end
    #config.vm.provision "shell", path: "prometheus/prometheus.sh"
  end
  
  config.vm.define "elk01" do |subconfig|
    subconfig.vm.box = "debian/stretch64"
    subconfig.vm.hostname = "elk01"
    subconfig.vm.network :private_network, ip: "192.168.121.15"
    subconfig.vm.network :forwarded_port, guest: 5601, host: 5601
    subconfig.vm.provision "shell", path: "elk/elk.sh"
    #subconfig.vm.provision "shell", path: "prometheus/node_exporter.sh"
    #subconfig.vm.provision "ansible" do |ansible|
    #    ansible.playbook = "webserver/webserver.yml"
    #end
    subconfig.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 1
    end
  end
end