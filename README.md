System-wide config of mirrors-main
----------------------------------


```
rm /etc/fstab; ln -s `pwd`/fstab /etc/fstab
ls lxc | while read f; do rm /var/lib/lxc/$f/config; ln -s `pwd`/lxc/$f /var/lib/lxc/$f/config; done
```

```rc.local``` should be specially treated (see ```rc.local``` file)
