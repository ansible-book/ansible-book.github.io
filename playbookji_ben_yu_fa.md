# Playbook基本语法


## 执行Playbook语法


```bash
$ ansible-playbook deploy.yml
```
查看输出的细节


```ansible-playbook playbook.yml --list-hosts```

查看该脚本影响哪些hosts

```ansible-playbook playbook.yml --list-hosts```




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




**hosts**：为主机的IP，或者主机组名，或者关键字all

**remote_user**: 以哪个用户身份执行。

**vars**： 变量

**tasks**: playbook的核心，定义顺序执行的action。每个action调用一个module。 action 语法： ```action: module options```

**handers**： playbook的event，默认不会执行，在action里trigger才会执行。多次trigger只执行一次。

deploy.yml示例：

```yml
---
- hosts: webservers
  vars:
    http_port: 80
    max_clients: 200
  remote_user: root
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