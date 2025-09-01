# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "controller" do |node|
      node.vm.hostname = "controller"
      node.vm.box = "ubuntu/jammy64"
      
      node.vm.network "private_network", ip: "192.168.56.2"
      
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end
    end
  config.vm.define "dns" do |node|
      node.vm.hostname = "dns"
      node.vm.box = "ubuntu/jammy64"
      
      node.vm.network "private_network", ip: "192.168.56.3"
      
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end
      node.vm.provision "shell", inline: <<-SHELL
          chmod +x /vagrant/scripts/setup-dns.sh
          /vagrant/scripts/setup-dns.sh
          echo "* * * * * root /vagrant/scripts/monitor-service.sh bind9" | sudo tee /etc/cron.d/monitor-bind9
      SHELL
    end
  N = 3
  (1..N).each do |i|
    config.vm.define "web-#{i}" do |node|
      node.vm.hostname = "web-#{i}"
      node.vm.box = "ubuntu/jammy64"
      
      node.vm.network "private_network", ip: "192.168.56.#{10 + i}"
      
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end
      
      node.vm.provision "shell", inline: <<-SHELL
          chmod +x /vagrant/scripts/setup-apache.sh
          /vagrant/scripts/setup-apache.sh
          echo "* * * * * root /vagrant/scripts/monitor-service.sh apache2" | sudo tee /etc/cron.d/monitor-apache
      SHELL
    end
  end
  config.vm.define "loadbalancer" do |node|
      node.vm.hostname = "loadbalancer"
      node.vm.box = "ubuntu/jammy64"
      
      node.vm.network "private_network", ip: "192.168.56.14"
      
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end
      
      node.vm.provision "shell", inline: <<-SHELL
          chmod +x /vagrant/scripts/setup-nginx.sh
          /vagrant/scripts/setup-nginx.sh
          echo "* * * * * root /vagrant/scripts/monitor-service.sh nginx" | sudo tee /etc/cron.d/monitor-nginx
      SHELL
    end
end
