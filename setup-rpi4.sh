#!/bin/bash -xe

cd ~

#select from outside dpi_firmware
mix dpi.select rpi4

cd ~/release/dpi_firmware

mix dpi deps.get
mix dpi compile

cd ~
