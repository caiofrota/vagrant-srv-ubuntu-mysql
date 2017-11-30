Vagrant.configure("2") do |config|
	# Base machine.
    config.vm.box = "ubuntu/xenial64"
	
	# Enable ports.
    config.vm.network :forwarded_port, guest: 80, host: 8080
	config.vm.network :forwarded_port, guest: 3306, host: 3306
	
	# Create a shared folder.
    config.vm.synced_folder "./vagrant", "/vagrant", :mount_options => ["dmode=777","fmode=666"]
	
	# Configure VirtualBox.
    config.vm.provider "virtualbox" do |machine|
    	machine.memory = 1024
    	machine.name = "srv-ubuntu1604-mysql"
    end
	
	# Install packages.
    config.vm.provision :shell, path: "bin/setup-mysql-server-5.7.sh"
end
