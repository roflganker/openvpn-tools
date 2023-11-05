#!/bin/sh

git clone https://github.com/roflganker/dockovpn-tcp.git dockovpn
cd dockovpn
touch .env
echo "HOST_ADDR=$(curl -s https://api.ipify.org)" >> .env
echo "HOST_TUN_PORT=1194" >> .env
echo "NET_ADAPTER=eth0" >> .env
docker compose build
docker compose up -d
sleep 3

docker compose exec dockovpn ./genclient.sh o
