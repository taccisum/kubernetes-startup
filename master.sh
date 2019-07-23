#!/bin/bash
cd `dirname $0`

source ./log.sh
source ./check.sh

h1 '准备启动kubernetes master节点'

info '执行检查操作'

check_docker_ce
if [ $? -eq 1 ];then
    info '准备安装docker'
    VERSION=DOCKER_VERSION ./prepare/docker.sh
fi

check_docker_ce
if [ $? -eq 1 ];then
    info '准备安装kubenetes'
    VERSION=KUBE_VERSION ./prepare/kubeadm.sh
fi

# init control plane node 
info '初始化master节点'
kubeadm init --image-repository registry.aliyuncs.com/google_containers

info '修改apiserver insecure port，允许8080端口访问'
sed -i 's/insecure-port=0/insecure-port=8080/g' /etc/kubernetes/manifests/kube-apiserver.yaml
