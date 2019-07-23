#!/bin/bash

# MASTER_API_SERVER | ip:port | 192.168.0.207:6443
# TOKEN | string | sjnl0w.j0tltfmnr62rfzzw
# CA_CERT_HASH | string | sha256:2f95521879a56654a3658d120d5d75d70edd1b043eb105bf7c3731ef467eadb6

cd `dirname $0`

source ./log.sh
source ./check.sh

function help_info() {
    info '使用示例: MASTER_API_SERVER=192.168.0.207:6443 TOKEN=sjnl0w.j0tltfmnr62rfzzw CA_CERT_HASH=sha256:2f95521879a56654a3658d120d5d75d70edd1b043eb105bf7c3731ef467eadb6 ./worker.sh'
}

function check_param() {
    env_var=$1
    val=`eval echo '$'"$env_var"`
    if [ -z $val ];then
        error '缺少参数'$1
        help_info
        exit 1
    fi
}

function check_params() {
    info '检查参数'
    check_param 'MASTER_API_SERVER'
    check_param 'TOKEN'
    check_param 'CA_CERT_HASH'
}

h1 '准备启动kubernetes worker节点'

info '执行检查操作'

check_params

check_docker_ce
if [ $? -eq 1 ];then
    info '准备安装docker'
    VERSION=$DOCKER_VERSION . ./prepare/docker.sh
fi

check_kubenetes
if [ $? -eq 1 ];then
    info '准备安装kubenetes'
    VERSION=$KUBE_VERSION . ./prepare/kubernetes.sh
fi

info '禁用交换内存'
./prepare/swapoff.sh

info '准备加入kubernetes集群，目标master：'$MASTER_API_SERVER
kubeadm join $MASTER_API_SERVER \
    --token $TOKEN \
    --discovery-token-ca-cert-hash $CA_CERT_HASH

if [ $? -eq 0 ];then
    success '加入集群成功'
else
    error '加入集群失败'
    exit 1
fi
