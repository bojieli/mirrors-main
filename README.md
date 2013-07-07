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

## Notice

Except for emergent cases, changes should be made on your own machine, pushed to gitlab and pulled to the server.

If you are not sure of your changes, please test it on your own machine before committing.
