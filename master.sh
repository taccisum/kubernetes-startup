#!/bin/bash
cd `dirname $0`

source ./log.sh

h1 '准备启动kubernetes master节点'

# init control plane node 
info '初始化master节点'
kubeadm init \
--image-repository registry.aliyuncs.com/google_containers \
--pod-network-cidr=10.244.0.0/16

if [ $? -eq 0 ];then
    success '初始化master节点成功'
    info '修改apiserver insecure port，允许8080端口访问'
    sed -i 's/insecure-port=0/insecure-port=8080/g' /etc/kubernetes/manifests/kube-apiserver.yaml
    info '安装网络组件'
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    info 'iptable放行'
    iptables -P INPUT ACCEPT && iptables -P FORWARD ACCEPT && iptables -I FORWARD -s 0.0.0.0/0 -j ACCEPT
else
    error '初始化master节点失败'
    exit 1
fi
