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
- Setup the `VSCode ElixirLS` plugin on the ssh host
- Attach your USB storage device using the VirtualBox UI
- Burn an image with either:
```bash
~/release/burn.sh rpi4 #or rpi3
```
- Update `~/.dpi_mix.exs` host and bid:
    - Get the IP by pressing `[F6] Show Info` at the `Network Manager` screen and use it as `host`
    - Get the BID from the `About` screen and use it as `bid`
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
