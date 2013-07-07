System-wide config of mirrors-main
----------------------------------


```
ln -s fstab /etc/fstab
ls lxc/ | do read $f; ln -s lxc/$f /var/lib/lxc/$f/config; done
```

```rc.local``` should be specially treated (see ```rc.local``` file)
