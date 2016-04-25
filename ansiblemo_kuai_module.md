# Ansible模块Module


## 什么是Ansible Module？
* Module是通过命令或者Playbook可以执行的task的插件

* Module是用Python写的。

* Ansible提供一些常用的Module http://docs.ansible.com/ansible/modules_by_category.html

* Ansible提供API，用户可以自己写Module




## Module在命令里使用Module

```
$ ansible all -m copy -a "src=/etc/hosts dest=/tmp/hosts"
$ ansible web -m yum -a "name=httpd state=present"

```


## Ansilbe在Playbook使用Module


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