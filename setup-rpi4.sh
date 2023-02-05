#!/bin/bash -xe

cd ~/release/dpi_firmware

mix dpi.select rpi4
mix dpi deps.get
mix dpi compile

cd ~
