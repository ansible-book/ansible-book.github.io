# Playbook基本语法

本节列举了写第一个Playbook，你必须了解基本语法。

随着你面临的机器越多，配置的需求越复杂，你可能需要了解后面介绍的一些稍微复杂逻辑的语句。

## 执行Playbook语法

```bash
$ ansible-playbook deploy.yml
```

查看输出的细节

```
ansible-playbook playbook.yml  --verbose
```

查看该脚本影响哪些hosts

```
ansible-playbook playbook.yml --list-hosts
```

并行执行脚本

```
ansible-playbook playbook.yml -f 10
```

## 完整的playbook脚本示例

最基本的playbook脚本分为三个部分:

1. 在什么机器上以什么身份执行

  * hosts
  * users
  * ...

2. 执行的任务是都有什么

  * tasks

3. 善后的任务都有什么

  * handlers


deploy.yml文件

```yml
---
- hosts: webservers
  vars:
    http_port: 80
    max_clients: 200
  user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest
  - name: write the apache config file
    template: src=/srv/httpd.j2 dest=/etc/httpd.conf
    notify:
    - restart apache
  - name: ensure apache is running
    service: name=httpd state=started
  handlers:
    - name: restart apache
      service: name=httpd state=restarted
```

