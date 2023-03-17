# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/jammy64"

  # speed up apt-get

  PROXY_ENABLE		= true
  PROXY_HTTP		= "http://10.0.2.2:5865"
  PROXY_HTTPS		= "http://10.0.2.2:5865"
  PROXY_EXCLUDE 	= "localhost,127.0.0.1"  

  
  if not Vagrant.has_plugin?("vagrant-proxyconf")
	PROXY_ENABLE == false
	config.vm.post_up_message = "Proxy config plugin not present, proxy instructions will be ignored"
  end
	if PROXY_ENABLE == true
		config.vm.post_up_message = "setting proxy config"
		config.proxy.http     = PROXY_HTTP
		config.proxy.https    = PROXY_HTTPS
		config.proxy.no_proxy = PROXY_EXCLUDE 
	end

	config.vm.hostname = "postgresql.test"
	config.vm.provider "virtualbox" do |vb|
		vb.name = "postgresql"
		vb.memory = "1024"
		vb.cpus = 2
	end
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 5432, host: 5433

  # Run the shell script inline provisioner
  #config.vm.provision "shell", inline: $script

	config.vm.provision "shell", path: "./scripts/provision_db.sh"	

end
