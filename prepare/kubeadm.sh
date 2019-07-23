#!/bin/bash

# 支持的环境变量：
# Name    | Type   | Example
# VERSION | string | 1.15.1

cd `dirname $0`

source ../log.sh

h1 '准备安装Kubernetes'

info '配置yum镜像源，使用阿里云加速下载kubernetes'
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

info '禁用SELinux，开放容器访问主机文件系统权限'
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

if [ -z $VERSION ];then
    info '安装最新版本kubernetes（可以通过环境变量VERSION指定版本）'
    yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
else
    info '安装'$VERSION'版本kubernetes'
    yum install -y kubelet-$VERSION kubeadm-$VERSION kubectl-$VERSION --disableexcludes=kubernetes
fi

if [ $? -eq 0];then
    success '安装Kubernetes成功'
    info '启动kubelet'
    systemctl enable --now kubelet
else
    error '安装Kubernetes失败'
    exit 1
fi
