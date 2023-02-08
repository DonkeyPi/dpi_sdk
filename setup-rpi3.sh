#!/bin/bash -xe

cd ~/release/dpi_sdk/hello_world
mix dpi.select rpi3
mix dpi deps.get
mix dpi compile
