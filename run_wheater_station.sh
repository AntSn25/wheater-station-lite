#!/bin/bash
# first argument is your desired port
sudo docker run -d --rm --device /dev/i2c-1 --name wheater-container-lite -p $1:5000 wheater-station-lite
