#!/bin/sh

ip="$(curl -s https://api.ipify.org/)"
echo "Your ip is $ip"
