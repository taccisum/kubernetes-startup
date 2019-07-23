#!/bin/bash
cd `dirname $0`

source ./log.sh

# init control plane node 
kubeadm init --image-repository registry.aliyuncs.com/google_containers

sed -i 's/insecure-port=0/insecure-port=8080/g' /etc/kubernetes/manifests/kube-apiserver.yaml
