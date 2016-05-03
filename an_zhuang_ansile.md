# 安装Ansile


## 管理员的电脑上：


安裝Ansible

```
$ sudo yum install ansible -y 
```

配置Ansible

```

$ ssh-keygen
 
$ ssh-copy-id remoteuser@remoteserver
 
$ ssh-keyscan remote_servers >> ~/.ssh/known_hosts
 ```


## 被管理的远程主机：



不需要安装特殊的包，只需要python>2.4，一般系统都会自带。