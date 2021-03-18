BOX_IMAGE = "ubuntu/xenial64"
NODE_COUNT = 2

Vagrant.configure("2") do |config|

  config.vm.define "primary" do |primary|
    
    primary.vm.box = BOX_IMAGE
    primary.vm.hostname = "primary"
    primary.vm.network :public_network, bridge: "enp2s0"
    
    primary.vm.provider :virtualbox do   |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--cpus", 2]
      v.customize ["modifyvm", :id, "--name", "primary"]
  end
end
  
  (1..NODE_COUNT).each do |i|
    config.vm.define "replica#{i}" do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "replica#{i}"
      subconfig.vm.network :public_network, bridge: "enp2s0"
      subconfig.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 2048]
        v.customize ["modifyvm", :id, "--cpus", 2]
        v.customize ["modifyvm", :id, "--name", "replica#{i}"]
    end
  end

  # Install dependencies for kubernetes 
  config.vm.provision "shell", path: "script.sh"
end
end