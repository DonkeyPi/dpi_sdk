# DonkeyPI SDK

The DonkeyPI SDK is delivered in the form of a vagrand/virtualbox VM that, after the vagrant build completes successfully, will include all the tools required to burn the DonkeyPI Firmware and deploy DonkeyPI Applications over the network. To use the tools we need to connect to the SDK VM from VSCode over SSH using the Remote SSH extension.

## Requirements

- A development machine running Windows, Linux, or OSX amd64
- A Raspberry PI 3 or 4 with its official Touch Screen 800x480
- A microSD USB card writer and an empty microSD card
- Optional: USB keyboard/mouse combo

## Setup

- Install [VirtualBox 6.1.36 and Extension Pack](https://download.virtualbox.org/virtualbox/6.1.36/)
- Install [Vagrant 2.3.4](https://releases.hashicorp.com/vagrant/2.3.4/) (Windows, Linux, and OSX amd64 only)
- Install [Visual Studio Code with Remote - SSH Extension](https://code.visualstudio.com/docs/remote/ssh)
- Build the SDK VM:
```bash
git clone https://github.com/DonkeyPi/dpi_sdk
cd dpi_sdk
vagrant up
vagrant ssh-config
```
- These [slides](https://docs.google.com/presentation/d/18vayymWrIjg5twljmce3K60IyG-qcv1i7YxsMlNSy3w/edit?usp=sharing) visually complement the steps below
- Use `vagrant ssh-config` output to setup a host in your `~/.ssh/config` file
- Connect to the ssh host from VSCode Remote SSH plugin
- Setup the `VSCode ElixirLS` plugin on the ssh host
- Attach your USB storage device using the VirtualBox UI
- Open a VSCode terminal pointing to the SDK VM home folder
- Burn an image with either:
```bash
~/release/burn.sh rpi4 #or rpi3
```
- Update `~/.dpi_mix.exs` host and bid:
    - Get the IP by pressing `[F6] Show Info` at the `Network Manager` screen and use it as `host`
    - Get the BID from the `About` screen and use it as `bid`
- Deploy the `hello_world` sample application with:
```bash
cd ~/release/dpi_sdk/hello_world
mix dpi.select rpi4 #or rpi3
mix dpi deps.get
mix dpi.sign
mix dpi.install
mix dpi.uninstall
```
- Read the documentation (on the making)
