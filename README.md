# OpenVPN tools

## Motivation

Many state-related ISPs managed to block OpenVPN via packet inspection.
One of ways to bypass OpenVPN blocking is to run it over an SSH tunnel, so,
these tools are intended to glue ssh and vpn.

## Requirements

On your server side

1. VDS/VPS running linux
2. OpenVPN server working over TCP, as example [dockovpn-tcp](https://github.com/roflganker/dockovpn-tcp)

On your client side

1. SSH access to your server
2. OpenVPN client software installed
3. Root (sudo) priveleges

## Getting started

### Obtaining scripts

```shell
git clone https://github.com/roflganker/openvpn-tools.git
cd openvpn-tools
chmod +x *.sh
```

### Obtainign OpenVPN client configration

Just place `client.ovpn` under `./clients/<host>.ovpn`.

Also consider this:
- UDP clients will not work, don't even try
- As we connect over tunnel, remote address should be `remote localhost 1194`
- SSH client should connect over a common gateway. `route <vds_id> 255.255.255.255 net_gateway`

### Statring the tunnel

```shell
./up.sh username@host
# Now test connectivity
sleep 5;
./test.sh
ping 1.1.1.1
ping <anything>
```

### Stopping the tunnel

```shell
./down.sh
```

### Chaining multiple tunnels

Soon.
