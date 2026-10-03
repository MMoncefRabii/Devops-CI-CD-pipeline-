Vagrant.configure("2") do |config|
# Box
config.vm.box = "bento/ubuntu-22.04"
# Réseau
config.vm.network "private_network", ip: "192.168.33.10"
# Hardware
config.vm.provider "virtualbox" do |vb|
vb.memory = "4000"
vb.cpus = "2"
end
end