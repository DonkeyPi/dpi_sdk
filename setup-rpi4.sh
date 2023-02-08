#!/bin/bash -xe

cd ~/release/dpi_sdk/hello_world
mix dpi.select rpi4
mix dpi deps.get
mix dpi compile
