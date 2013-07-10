#!/bin/bash
## script for creating LXC container

TEMPLATE_CONF="./lxc-template/config"
LXC_ROOT="/var/lib/lxc"

if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: ./create-lxc.sh <container-name> <root-partition-size>"
    echo "Example: ./create-lxc.sh my-container 5G"
    exit 1
fi
if [ `whoami` != "root" ]; then
    echo "You must be root to run this script"
    exit 1
fi

# should be run in current directory
cd `dirname $0`

container=$1
fssize=$2
lxc-create -n $container -t debian -B lvm --lvname $container --vgname vg-xvda2-730g --fstype ext4 --fssize $fssize

echo "/dev/vg-xvda2-730g/$container		/var/lib/lxc/$container/rootfs		ext4	defaults	0	2" >> fstab
mount -a

# generate config file
sed "s/%container%/$container/g" <$TEMPLATE_CONF >$LXC_ROOT/$container/config

# fix tty
for i in {1..6}; do
    touch $LXC_ROOT/$container/rootfs/dev/tty$i
done

# clear root password
chroot $LXC_ROOT/$container/rootfs passwd -d root