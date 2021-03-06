# System-wide config of mirrors-main

## Deploy for a new server

1. ```sudo -i```
2. ```ssh-keygen``` and add ```~/.ssh/id_rsa.pub``` to Deploy Key on Gitlab.
3. Make sure this repository is in /opt/ustclug/mirrors-main/ on the server.
4. Run ./deploy.sh to deploy.

## Making Changes

1. Make changes on your own machine
2. Commit and push it to gitlab
3. Login to mirrors-main and ```sudo -i```
4. ```cd /opt/ustclug/mirrors-main```
5. ```git pull```
6. ```./deploy.sh```
7. Make sure that all services are OK. If not, check your changes and fix it!

### Notice

Except for emergent cases, changes should be made on your own machine, pushed to gitlab and pulled to the server.

If you are not sure of your changes, please test it on your own machine before committing.

# LXC

## List LXC
```lxc-list```

## LXC console

In host machine:
```lxc-console -n <container-name>```

To detach from LXC console, type ```Ctrl+A Q```

If the LXC is created with our script, it should be able to login with ```root``` without password.

## Start LXC
```./start-lxc.sh <container-name>```

Please always use ```start-lxc.sh``` to start containers. If you wish to do something else, write it in the script.

## Stop LXC
```lxc-stop -n <container-name>```

Most changes to LXC config file require restarting (stop, then start) LXC to take effect.

## Create a new LXC
```./create-lxc.sh <container-name> <root-partition-size>```

Please following the instructions on the screen.

After installation, the script will fix config file, fstab and tty files, and clear root password.

Manually create LXC:
```lxc-create -n <container-name> -t debian -B lvm --lvname <logical-volume-name> --vgname vg-xvda2-730g --fstype ext4 --fssize <root-partition-size>```

## Destroy LXC
```lxc-destroy -n <container-name>```

WARNING: Destroy is permanent and not recoverable.
