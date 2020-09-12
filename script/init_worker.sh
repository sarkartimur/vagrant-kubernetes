#!/bin/bash

kubeadm join $1:6443 --token $(cat /vagrant/.data/token) --discovery-token-unsafe-skip-ca-verification