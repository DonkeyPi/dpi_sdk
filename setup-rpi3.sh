#!/bin/bash -xe

cd ~

#select from outside dpi_firmware
mix dpi.select rpi3

cd ~/release/dpi_firmware

mix dpi deps.get
mix dpi compile

cd ~
