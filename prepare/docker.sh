#!/bin/bash
cd `dirname $0`

source ../log.sh

h1 '准备安装docker'

# install docker-ce
yum install -y yum-utils device-mapper-persistent-data lvm2 && \
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo && \
sudo yum makecache fast && \
sudo yum -y install docker-ce
