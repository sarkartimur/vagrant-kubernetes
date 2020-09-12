#!/bin/bash

echo "INIT KUBERNETES CONTROL PLANE WITH PERMANENT TOKEN"
kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=$1 --token-ttl=0

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant /home/vagrant/.kube/config


echo "BRING UP THE POD NETWORK"
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo "STORE TOKEN FOR WORKER NODE"
mkdir /vagrant/.data && kubeadm token list | grep -P -o '^.*?(?=\s*<)' >> /vagrant/.data/token

echo "ENABLE DASHBOARD"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

echo "CREATE SERVICEACCOUNT AND BIND ROLE"
kubectl apply -f /vagrant/config/serviceaccount.yaml
kubectl apply -f /vagrant/config/rolebinding.yaml

echo "STORE TOKEN FOR DASHBOARD ACCESS"
kubectl get secret -n kube-system $(kubectl get serviceaccount -n kube-system ui-admin -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode >> /vagrant/.data/dashboard-token

echo "EXPOSE DASHBOARD THROUGH NODEPORT"
kubectl delete service kubernetes-dashboard -n kubernetes-dashboard
kubectl apply -f /vagrant/config/dashboard_nodeport_patch.yaml