Sets up a local Kubernetes cluster consisting of 1 master node and 1 worker node using vagrant with virtualbox provider.

## System requirements
- Vagrant
- Oracle VirtualBox
- 2 CPU cores (or hyper threads) for master node
- 2GB of RAM for master node
- 2 CPU cores (or hyper threads) for worker node
- 2GB of RAM for worker node

## Usage
```
vagrant up
```

After the installation has completed Kubernetes dashboard ui can be accessed at https://192.168.99.10:30443. Paste token from /vagrant/.data/dashboard-token.