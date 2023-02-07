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
$ git clone https://github.com/DonkeyPi/dpi_sdk
$ cd dpi_sdk
$ vagrant up
$ vagrant ssh-config
```
- These [slides](https://docs.google.com/presentation/d/18vayymWrIjg5twljmce3K60IyG-qcv1i7YxsMlNSy3w/edit?usp=sharing) visually complement the steps below
- Use `vagrant ssh-config` output to setup a host in your `~/.ssh/config` file
- Connect to the ssh host from VSCode Remote SSH plugin
- Setup the `VSCode ElixirLS` plugin on the ssh host
- Attach your USB storage device using the included script
```bash
$ ./attach.sh
1 Cambridge Silicon Radio, Ltd CSR8510 A10
2 Generic USB3.0 Card Reader
...
Select device to attach: 2
```
- Open a VSCode terminal pointing to the SDK VM home folder
- Burn an image with:
```bash
dpi-sdk:~$ ~/release/burn.sh rpi4 #or rpi3
...
==> dpi_firmware
Use 29.76 GiB memory card found at /dev/sdb? [Yn]
100% [====================================] 42.92 MB in / 53.45 MB out       
Success!
Elapsed time: 3.885 s
```
- Update `host` and `bid` in `~/.dpi_mix.exs` for your runtimes:
    - Get the IP by pressing `[F6] Show Info` at the `Network Manager` screen and use it as `host`
    - Get the BID from the `About` screen and use it as `bid`
```bash
dpi-sdk:~$ cat ~/.dpi_mix.exs 
[
  dpi_runtimes: [
    {:rpi3, target: :rpi3, host: "10.77.4.55", bid: "dpi-7d032302"},
    {:rpi4, target: :rpi4, host: "10.77.3.176", bid: "dpi-b3fc4ad8"}
  ]
]
```
- Deploy the `hello_world` sample application with:
```bash
dpi-sdk:~$ cd ~/release/dpi_sdk/hello_world
dpi-sdk:~$ mix dpi.select rpi4 #or rpi3
dpi-sdk:~$ mix dpi deps.get
dpi-sdk:~$ mix dpi.sign
dpi-sdk:~$ mix dpi.install
Generated hello_world app
...
Bundle : /home/vagrant/release-0.0.1/dpi_sdk/hello_world/_build/rpi4_dev/hello_world.tgz
Uploading to: {:rpi4, [variant: :rpi4, port: 8022, target: :rpi4, host: "10.77.3.176", bid: "dpi-b3fc4ad8"]}
Uploading bundle: hello_world.tgz
Installing on: {:rpi4, [variant: :rpi4, port: 8022, target: :rpi4, host: "10.77.3.176", bid: "dpi-b3fc4ad8"]}
22:03:18.984 PID<0.1129.0> Dpi.Runtime.Manager Starting app hello_world

#uninstall the application
dpi-sdk:~$ mix dpi.uninstall
Uninstalling on: {:rpi4, [variant: :rpi4, port: 8022, target: :rpi4, host: "10.77.3.176", bid: "dpi-b3fc4ad8"]}
22:23:24.003 PID<0.1129.0> Dpi.Runtime.Manager UNINSTALL hello_world
22:23:24.003 PID<0.1129.0> Dpi.Runtime.Manager Found /data/dpi_apps/hello_world.lib
22:23:24.004 PID<0.1129.0> Dpi.Runtime.Manager Stopping app hello_world
22:23:24.004 PID<0.1129.0> Dpi.Runtime.Manager Uninstalling /data/dpi_apps/hello_world.lib
```
- Read the documentation (on the making)
