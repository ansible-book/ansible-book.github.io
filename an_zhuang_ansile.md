# 安装Ansile

这里以RedHat Linux为例，其他系统请参考ansible的官网


## 管理员的电脑上：


* 安裝Ansible软件

```
$ sudo yum install ansible -y 
```

* 配置Ansible管理节点和主机的连接

其实就是配置从**管理节点到远程主机**之间基于key（无密码的方式）的**SSH连接**：

```
$ ssh-keygen
 
$ ssh-copy-id remoteuser@remoteserver
 
$ ssh-keyscan remote_servers >> ~/.ssh/known_hosts
 ```


## 被管理的远程主机：



不需要安装特殊的包，只需要python>2.4，RedHat Linux一般安装方式都自带。