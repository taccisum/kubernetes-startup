#!/bin/bash
cd `dirname $0`

source ./log.sh

function check_docker_ce() {
    info '检查docker-ce安装情况'
    docker --version &> /dev/null
    if [ $? -eq 0 ];then
        success 'docker-ce已安装'
    else
        error 'docker-ce未安装'
        return 1
    fi
}

function check_kubenetes() {
    info '检查kubenetes安装情况'
    kubeadm version &> /dev/null
    if [ $? -eq 0 ];then
        success 'kubenetes已安装'
    else
        error 'kubenetes未安装'
        return 1
    fi
}
