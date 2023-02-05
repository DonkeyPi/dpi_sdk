# Vagrant

- Pros: USB device access thru VirtualBox UI.
- Cons: No OSX M1 support. Slower than docker. GuestAdditions version sync.

```bash
vagrant box list
vagrant box remove roboxes/alpine316
#build the vm
vagrant up
vagrant ssh
vagrant halt
vagrant destroy
vagrant upload setup.sh

# https://releases.hashicorp.com/vagrant/2.3.4/
# https://download.virtualbox.org/virtualbox/6.1.36/
# roboxes/alpine316 Guest Additions Version: 6.1.36

#usb tricks
#https://softwaretester.info/virtualbox-usb-passthrough/
VBoxManage list vms
VBoxManage list usbhost
VBoxManage controlvm "vagrant_default_1675550286739_41994" usbattach "b03331a1-0dc8-4489-a0d8-2f7660e42972"
VBoxManage controlvm "vagrant_default_1675550286739_41994" usbdetach "b03331a1-0dc8-4489-a0d8-2f7660e42972"

#~/release/burn.sh rpi4
#~/release/burn.sh rpi3

#ssh tricks
vagrant ssh-config > ssh-config
ssh -F ssh-config default
scp -F ssh-config -r setup*.sh default:
#fails on hex install
ssh -F ssh-config default < setup.sh
```
