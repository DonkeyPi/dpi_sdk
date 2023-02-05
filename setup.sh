#!/bin/bash -xe

cd ~

#get release files
RELEASE=0.0.1
REMOTE=rsync://yeico.com/dpi
rsync -qr $REMOTE/release-$RELEASE . --delete
ln -sf release-$RELEASE release

#ssh login complains
touch ~/.bashrc

#install asdf
sudo apk add git
[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
echo ". ~/.asdf/asdf.sh" >> ~/.bash_profile
. ~/.asdf/asdf.sh

asdf plugin add erlang
asdf plugin add elixir

sudo apk add build-base ncurses perl openssl-dev automake autoconf ncurses-dev

erlang=`grep erlang ~/release/tool-versions.txt`
elixir=`grep elixir ~/release/tool-versions.txt`

asdf install $erlang
asdf global $erlang

asdf install $elixir
asdf global $elixir

mix local.hex --force
mix local.rebar --force
nbv=`cat ~/release/nerves_bootstrap.txt`
mix archive.install hex nerves_bootstrap $nbv --force

cd ~/release

#prevent failure on empty glob during testing
shopt -s dotglob nullglob

for src in *.tgz.src
do
    src=${src%.src}
    mv $src.src $src
    tar -xzf $src
done

(cd dpi_mix && mix deps.get)
(cd dpi_mix && mix archive.install --force)

#nano ~/.dpi_mix.exs
sudo apk add nano

cd ~

if [ ! -f ~/.dpi_mix.exs ]; then
    cp ~/release/dpi_mix.exs ~/.dpi_mix.exs
    hostname=`hostname`
    sed -i "s/hostname/$hostname/g" ~/.dpi_mix.exs
fi
mix dpi.select

cd ~

[ -f ~/.ssh/id_rsa ] || mix dpi.keygen
cp ~/release/config.ssh ~/.ssh/config
cat ~/release/id_rsa.key > ~/.ssh/id_rsa
cat ~/release/id_rsa.pub > ~/.ssh/id_rsa.pub

#https://github.com/raspberrypi/usbboot
sudo apk add git libusb-dev
[ -d ~/usbboot ] || git clone --depth=1 https://github.com/raspberrypi/usbboot
(cd usbboot && make)
#~/usbboot/rpiboot

#https://hexdocs.pm/nerves/installation.html
sudo apk add fwup squashfs-tools

#~/release/burn.sh rpi4
#~/release/burn.sh rpi3

# for nerves sdk
sudo apk add xz

# for vscode
sudo apk add gcompat
