# Ansible用命令管理主机

Ansbile Ad-Hoc Commands

命令的格式是：

```
ansible <host-pattern> [options]
```


### 检查ansible安装环境



检查所有的server，是否以bruce用户创建了ansible主机可以访问的环境。

```$ansible all -m ping -u jshi```


### 执行命令


在所有的server上，以当前bash的同名用户，在远程主机执行“echo bash”

```$ansible all -a "/bin/echo hello"```

### 并行执行


启动10个并行进行执行重起


```$ansible lb -a "/sbin/reboot" -f 10```



### 拷贝文件


拷贝文件/etc/host到远程机器（组）atlanta，位置为/tmp/hosts

```$ ansible web -m copy -a "src=/etc/hosts dest=/tmp/hosts"```


### 安装包


远程机器（组）webservers安装yum包

```$ ansible web -m yum -a "name=acme state=present"```


### 添加用户



```$ ansible all -m user -a "name=foo password=<crypted password here>"```


### 下载git包




```$ ansible web -m git -a "repo=git://foo.example.org/repo.git dest=/srv/myapp version=HEAD"```


### 起服务



```$ ansible web -m service -a "name=httpd state=started"```

### 查看远程主机的全部系统信息！！！



```$ ansible all -m setup```
