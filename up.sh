#!/bin/sh

# Ensure temp directory for openvpn tools
tmp_dir=/tmp/ovpntools
if [ ! -d $tmp_dir ]; then
  mkdir $tmp_dir
fi

# Check if tunnel is already running
tunnel_pidfile=$tmp_dir/tunnel.pid
if [ -f $tunnel_pidfile ]; then
  if [ -s $tunnel_pid ]; then
    echo "SSH tunnel is already running under pid $(cat $tunnel_pidfile)"
    exit 1
  fi
fi

# Check if VPN client is already running
vpn_pidfile=$tmp_dir/openvpn.pid
if [ -f $vpn_pidfile ]; then
  if [ -s $vpn_pidfile ]; then
    echo "VPN client is already running under pid $(cat $vpn_pidfile)"
    exit 1
  fi
fi

host=$1
if [ -z $host ]; then
  echo "Missing first argument: host";
  echo "Usage: up <[user@](hostname|ip)[:port]>"
  echo "Usage: up <ssh host>"
  exit 1
fi

client="./clients/${host}.ovpn"
if [ ! -f $client ]; then
  echo "Missing Open VPN configuration."
  echo "Please place client configuration under ${client}"
  exit 1
fi

echo "Running SSH tunnel..."
port=1194
upstream=$port:localhost:$port
ssh $host -N -L $upstream &
tunnel_pid=$!
echo $tunnel_pid > $tunnel_pidfile
echo "SSH tunnel is up, pid ${tunnel_pid}"

echo "Running VPN client..."
sudo openvpn --config $client --writepid $vpn_pidfile --daemon
echo "VPN client is up, pid $(cat $vpn_pidfile)"
