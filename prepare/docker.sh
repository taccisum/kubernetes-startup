#!/bin/bash
cd `dirname $0`

source ../log.sh

h1 '准备安装docker-ce'

info '配置镜像源，使用阿里云加速下载docker-ce'
yum install -y yum-utils device-mapper-persistent-data lvm2 && \
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo && \
yum makecache fast

if [ -z $VERSION ];then
    info '安装最新版本docker-ce'
    yum -y install docker-ce
else
    info '安装版本docker-ce-'$VERSION
    yum -y install docker-ce-$VERSION
fi

if [ $? -eq 0];then
    success '安装docker-ce成功'
else
    error '安装docker-ce失败'
    exit 1
fi