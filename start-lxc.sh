#!/bin/bash
if [ -z $1 ]; then
	echo "Usage: ./start-lxc.sh <lxc-name>"
	exit 1
fi
if [ ! -f "/var/lib/lxc/$1/config" ]; then
	echo "Container $1 does not exist"
	exit 1
fi

#addr_nginx="10.87.0.1"
#v6addr_nginx="fec0::10:87:0:1"
#table_nginx=86

#addr_ftpd="10.88.0.1"
#v6addr_ftpd="fec0::10:88:0:1"
#table_ftpd=87

#addr_rsyncd="10.89.0.1"
#v6addr_rsyncd="fec0::10:89:0:1"
#table_rsyncd=88

lxc-start -n $1 -d


varname="addr_$1"
addr=${!varname}
if [ -z "$addr" ]; then
	exit 0 # no need to add addr
else
	sleep 2 # wait for LXC to init
fi
ip addr add $addr/30 dev veth-$1

varname="v6addr_$1"
v6addr=${!varname}
ip -6 addr add $v6addr/126 dev veth-$1

varname="table_$1"
table=${!varname}
if [[ "$1" == "nginx" || "$1" == "rsyncd" || "$1" == "ftpd" ]]; then
	ip route replace default via $addr dev veth-$1 table $table
	ip -6 route replace default via $v6addr dev veth-$1 table $table
	ip route flush cache
	echo 1 > /proc/sys/net/ipv4/conf/veth-$1/accept_local
fi
