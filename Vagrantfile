# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.hostname = "devops-vm"

  # Private IP: Jenkins -> :8080, SonarQube -> :9000, Adminer -> :8082, Grafana -> :3000
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.name   = "devops-vm"
    vb.memory = 6144   # use 4096 if your PC has 8 GB of RAM or less
    vb.cpus   = 2
  end

  # Named provisioners run in this order on the first "vagrant up".
  # Re-run just one with:  vagrant provision --provision-with docker
  config.vm.provision "base",   type: "shell", path: "provision/01-base.sh"
  config.vm.provision "docker", type: "shell", path: "provision/02-docker.sh"
  config.vm.provision "jenkins", type: "shell", path: "provision/03-jenkins.sh"
end
