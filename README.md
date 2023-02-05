# DonkeyPI SDK

## Setup

- Install [VirtualBox 6.1.36 and Extension Pack](https://download.virtualbox.org/virtualbox/6.1.36/)
- Install [Vagrant 2.3.4](https://releases.hashicorp.com/vagrant/2.3.4/) (Windows, Linux, and OSX amd64 only)
- Install [Visual Studio Code with Remote - SSH Extension](https://code.visualstudio.com/docs/remote/ssh)
```bash
clone https://github.com/DonkeyPi/dpi_sdk --branch v0.0.1
cd dpi_sdk
vagrant up
vagrant ssh-config
```
- Use `vagrant ssh-config` output to setup a host in your `~/.ssh/config` file.
- Connect to the ssh host from VSCode Remote SSH plugin
- Setup the `VSCode ElixirLS` plugin on the host
- Boot the Raspberry eMMC using the [usbboot](https://github.com/raspberrypi/usbboot) tool
    - [Windows](https://github.com/raspberrypi/usbboot/raw/master/win32/rpiboot_setup.exe) may need to install drivers from Windows Update
- Attach your USB storage device using the VirtualBox UI
- Burn an image with either:
```bash
~/release/burn.sh rpi4 #or rpi3
```
- Update `~/.dpi_mix.exs` with your raspberry pi host
    - The host is the ID in the `About` screen.
- Deploy the `hello_world` template with:
```bash
cd ~/release/hello_world
mix dpi.select rpi4 #or rpi3
mix dpi.install
```
- Read the documentation

## Linux Development

- Vagrant Pros: USB device access thru VirtualBox UI.
- Vagrant Cons: No M1 support. Slower. GuestAdditions version sync. VSCode missing glibc.

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
