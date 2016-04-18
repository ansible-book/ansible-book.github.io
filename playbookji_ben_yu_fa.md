# Playbook基本语法


## 执行Playbook语法


```bash
$ ansible-playbook deploy.yml
```
查看输出的细节


```
ansible-playbook playbook.yml --list-hosts
```

查看该脚本影响哪些hosts

```
ansible-playbook playbook.yml --list-hosts
```

并行执行脚本

```
ansible-playbook playbook.yml -f 10
```


## 主机和用户



| key | 含义  |
| -- | -- |
| **hosts** | 为主机的IP，或者主机组名，或者关键字all |
|**user** | 在远程以哪个用户身份执行。 |
| **become** | 切换成其它用户身份执行，值为yes或者no |
| **become_method** | 与became一起用，指可以为‘sudo’/’su’/’pbrun’/’pfexec’/’doas’ |
| **become_user** | 与bacome_user一起用，可以是root或者其它用户名 |

脚本里用became的时候，执行的playbook的时候可以加参数--ask-become-pass

```ansible-playbook deploy.yml --ask-become-pass```


## 任务列表

## Handlers
在操作改变时执行的action。在所有的任务里表执行之后执行，并且只执行一次。

```
- name: template configuration file
  template: src=template.j2 dest=/etc/foo.conf
  notify:
     - restart memcached
     - restart apache
```

## 完整的deploy.yml示例



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