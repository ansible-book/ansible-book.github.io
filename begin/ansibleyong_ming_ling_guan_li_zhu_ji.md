---
 layout: home
 title: Ansible用命令管理主机
---

# Ansible用命令管理主机
Ansible提供了一个命令行工具，在官方文档中起给命令行起了一个名字叫Ad-Hoc Commands。

ansible命令的格式是：

```
ansible <host-pattern> [options]
```

## ansible命令功能有哪些

先不用深纠命令的语法，讲完module那节，就可以理解语法。通过下面的命令感性地体会下ansible命令行的功能。

#### 检查ansible安装环境

检查所有的远程主机，是否以bruce用户创建了ansible主机可以访问的环境。

`$ansible all -m ping -u bruce`

#### 执行命令

在所有的远程主机上，以当前bash的同名用户，在远程主机执行“echo bash”

`$ansible all -a "/bin/echo hello"`

#### 拷贝文件

拷贝文件/etc/host到远程主机（组）web，位置为/tmp/hosts

`$ ansible web -m copy -a "src=/etc/hosts dest=/tmp/hosts"`

#### 安装包

远程主机（组）web安装yum包acme

`$ ansible web -m yum -a "name=acme state=present"`

#### 添加用户

`$ ansible all -m user -a "name=foo password=<crypted password here>"`

#### 下载git包

`$ ansible web -m git -a "repo=git://foo.example.org/repo.git dest=/srv/myapp version=HEAD"`

#### 启动服务

`$ ansible web -m service -a "name=httpd state=started"`

#### 并行执行

启动10个并行进行执行重起

`$ansible lb -a "/sbin/reboot" -f 10`

#### 查看远程主机的全部系统信息！！！

`$ ansible all -m setup`

