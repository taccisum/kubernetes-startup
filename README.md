# Kubernetes Startup Script

目前只支持`CentOS 7`单master集群启动。

此脚本仅供学习使用，方便入门者快速搭建起一个k8s集群。请勿用于生产环境，否则后果自负。

## How To

### 资源准备

准备主机（建议使用虚拟机）

- master主机 * 1，最低配置为2核2g
- worker主机 * n，最低配置无要求

然后为这些主机准备好相应的环境，执行

```shell
$ ./prepare.sh
```

### Init Cluster(Create Master Node)

```shell
$ ./master.sh
```

### Join Cluster(Create Worker Node)

```shell
$ MASTER_API_SERVER=192.168.0.1:6443 \
TOKEN=fwvu0o.c6u89xbrglse9lp4 \
CA_CERT_HASH=sha256:e6da2fc494e5aab3bfc4913e8fdedc9cb8028e67f82492030426aef512a3e445 \
./worker.sh
```

以上环境变量根据你在创建master节点时得到的信息做相应调整。
