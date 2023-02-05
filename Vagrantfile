Vagrant.configure("2") do |config|
    config.vm.box = "roboxes/alpine316"
    config.vm.box_version = "4.2.10"
    config.vm.hostname = "dpi"
    config.vm.provider "virtualbox" do |vb|
        vb.name = "DonkeyPi SDK 0.0.1"
        vb.customize ["modifyvm", :id, "--usb", "on"]
        vb.customize ["modifyvm", :id, "--usbxhci", "on"]
        vb.check_guest_additions = false
      end  
    config.vm.synced_folder ".", "/vagrant"
    config.vm.provision :shell, path: "bootstrap.sh"
    config.vm.provision :shell, path: "setup.sh", privileged: false
    config.vm.provision :shell, path: "setup-rpi3.sh", privileged: false
    config.vm.provision :shell, path: "setup-rpi4.sh", privileged: false
end
