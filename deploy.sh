#!/bin/bash

rm /etc/fstab; ln -s `pwd`/fstab /etc/fstab
ls lxc | while read f; do rm /var/lib/lxc/$f/config; ln -s `pwd`/lxc/$f /var/lib/lxc/$f/config; done

# The following line works if the repo is in /opt/ustclug/mirrors-main/
cp rc.local.entry /etc/rc.local
