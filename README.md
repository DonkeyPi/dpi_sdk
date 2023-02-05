# DonkeyPI SDK

## Setup

- Install [VirtualBox 6.1.36 and Extension Pack](https://download.virtualbox.org/virtualbox/6.1.36/)
- Install [Vagrant 2.3.4](https://releases.hashicorp.com/vagrant/2.3.4/) (Windows, Linux, and OSX amd64 only)
- Install [Visual Studio Code with Remote - SSH Extension](https://code.visualstudio.com/docs/remote/ssh)
```bash
git clone https://github.com/DonkeyPi/dpi_sdk --branch v0.0.1
cd dpi_sdk
vagrant up
vagrant ssh-config
```
- Use `vagrant ssh-config` output to setup a host in your `~/.ssh/config` file
- Connect to the ssh host from VSCode Remote SSH plugin
- Setup the `VSCode ElixirLS` plugin on the host
- Boot the Raspberry Pi eMMC using the [usbboot](https://github.com/raspberrypi/usbboot) tool
    - [Windows](https://github.com/raspberrypi/usbboot/raw/master/win32/rpiboot_setup.exe) may need to install drivers from Windows Update
- Attach your USB storage device using the VirtualBox UI
- Burn an image with either:
```bash
~/release/burn.sh rpi4 #or rpi3
```
- Update `~/.dpi_mix.exs` host:
    - Get the IP by pressing `[F6] Show Info` at the `Network Manager` screen.
    - Get the ID from the `About` screen and use it as hostname with suffix `.local`
    - Because of NAT networking, register the host in file `/etc/hosts` with:
```bash
echo "10.77.4.55 dpi-7d032302.local" | sudo tee -a /etc/hosts
ping dpi-7d032302.local #should work
```
- Deploy the `hello_world` template with:
```bash
cd ~/release/dpi_sdk/hello_world
mix dpi.select rpi4 #or rpi3
mix dpi deps.get
mix dpi.sign
mix dpi.install
mix dpi.uninstall
```
- Read the documentation (on the making)
