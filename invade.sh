#!/bin/sh

pssh=parallel-ssh
if ! [ -x "$(command -v $pssh)" ]; then
  echo "Error: $pssh is not installed";
  exit 1
fi

$pssh -h ./hosts.pssh -t 300 -o ./out -I < ./server.sh
