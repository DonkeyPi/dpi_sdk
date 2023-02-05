#!/bin/bash -xe

cd ~/release/dpi_firmware

mix dpi.select rpi3
mix dpi deps.get
mix dpi compile

cd ~
