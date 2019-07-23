#!/bin/bash

source ./log.sh
source ./check.sh

info '执行检查操作'

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

info '关闭防火墙'
./prepare/firewalldoff.sh

info '开启网桥过滤'
./prepare/networkon.sh

info '禁用交换内存'
./prepare/swapoff.sh
