Sets up a local Kubernetes cluster consisting of 1 master node and adjustable number of worker nodes using vagrant with virtualbox provider.

## System requirements
- Vagrant
- Oracle VirtualBox
- 2 CPU cores (or hyper threads) for master node
- 2GB of RAM for master node
- Number of worker nodes can be controlled by adjusting the WORKER_COUNT variable in vagrantfile
- Limits of worker nodes can be controlled by adjusting WORKER_MEMORY and WORKER_CPU variables in vagrantfile

## Usage
```
vagrant up
```

Kubernetes dashboard ui is reachable at https://192.168.99.10:30443. Paste token from /vagrant/.data/dashboard-token.
Docker registry is reachable at http://192.168.99.10:5000.