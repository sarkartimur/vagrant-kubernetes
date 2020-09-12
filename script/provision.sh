#!/bin/bash

echo "DISABLE SWAP"
swapoff -a
perl -pi -e 's/^(?=.*swap)/#/' /etc/fstab

echo "ENABLE HTTPS"
apt-get update
apt-get install -y apt-transport-https


echo "INSTALL DOCKER"
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -   

apt-get update
apt-get install -y docker.io


echo "INSTALL KUBERNETES"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# modprobe br_netfilter

apt-get update 
apt-get install -y kubeadm kubelet kubectl

echo 'Environment="cgroup-driver=systemd/cgroup-driver=cgroupfs"' >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf