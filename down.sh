#!/bin/sh

# Ensure temp directory
tmp_dir=/tmp/ovpntools
if [ ! -d $tmp_dir ]; then
  mkdir $tmp_dir
fi;

# Down VPN client
vpn_pidfile=$tmp_dir/openvpn.pid
if [ -f $vpn_pidfile ]; then
  vpn_pid="$(cat $vpn_pidfile)"
  if [ ! -z $vpn_pid ]; then
    echo "Stopping VPN client under pid ${vpn_pid}"

    # We use sudo because openvpn process owner is root
    sudo kill -15 $vpn_pid
  fi
  rm -f $vpn_pidfile
fi
echo "VPN client is down"

# Down SSH tunnel
tunnel_pidfile=$tmp_dir/tunnel.pid
if [ -f $tunnel_pidfile ]; then
  tunnel_pid="$(cat $tunnel_pidfile)"
  if [ ! -z $tunnel_pid ]; then
    echo "Stopping tunnel under pid ${tunnel_pid}"
    kill -15 $tunnel_pid
  fi
  rm -f $tunnel_pidfile
fi
echo "Tunnel is down"
