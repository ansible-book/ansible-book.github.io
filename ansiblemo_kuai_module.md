# Ansible模块Module


## 什么是Ansible Module？

bash无论在命令行上执行，还是bash脚本中，都需要调用cd、ls、copy、yum等命令；module就是Ansible的“命令”，module是ansible命令行和脚本中都需要调用的。常用的Ansible module有yum、copy、template等。

在bash，调用命令时可以跟不同的参数，每个命令的参数都是该命令自定义的；同样，ansible中调用module也可以跟不同的参数，每个module的参数也都是由module自定义的。

每个module的用法可以查阅文档。http://docs.ansible.com/ansible/modules_by_category.html



## Ansible在命令行里使用Module

在命令行中

> -m后面接调用module的名字
> 
> -a后面接调用module的参数

```
$ #使用module copy拷贝管理员节点文件/etc/hosts到所有远程主机/tmp/hosts
$ ansible all -m copy -a "src=/etc/hosts dest=/tmp/hosts"
$ #使用module yum在远程主机web上安装httpd包
$ ansible web -m yum -a "name=httpd state=present"

```


## Ansilbe在Playbook脚本使用Module

在playbook脚本中，tasks中的每一个action都是对module的一次调用。在每个action中：

> 冒号:前面是module的名字
> 
> 冒号:后面是调用module的参数

```
---
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest
  - name: write the apache config file
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
  - name: ensure apache is running
    service: name=httpd state=started

```

## Module的特性
* Module是通过命令或者Playbook可以执行的task的插件

* Module是用Python写的。

* Ansible提供一些常用的Module http://docs.ansible.com/ansible/modules_by_category.html

* 通过命令ansible-doc可以查看module的用法

* Ansible提供API，用户可以自己写Module