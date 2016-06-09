# Ansible的架构


Ansilbe管理员节点和远程主机节点通过ssh协议进行通信。只需要保证从Ansible管理节点通过SSH能够连接到被管理的远程的远程节点即可。

## 连接方式SSH
在管理员节点安装Ansible，编写脚本。在管理节点执行命令或者脚本时，通过SSH连接被管理的主机。  被管理的远程节点不需要进行特殊安装软件。

![](ansible-two-machine-edited.png)


## 支持多种类型的主机

Ansible可以同时管理Redhat系的Linux，Debian系的Linux，以及Windows主机。管理节点只在执行脚本时与远程主机连接，没有特别的同步机制。所以通过发生断电等异常一般不会影响ansbile。

![](ansible-multiple-machine-edited.png)