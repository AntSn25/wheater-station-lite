#!/bin/bash
echo "Stoppe den alten Container"
sudo docker stop wheater-container-lite

echo "Baue das Docker-Image und pushe es in die lokale Registry"
sudo docker build -t wheater-station-lite .

echo "Starte einen Container"
sudo docker run -d --rm --name wheater-container-lite --device /dev/i2c-1 -p 80:5000 wheater-station-lite