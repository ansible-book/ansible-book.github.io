# Playbook基本语法

创建文件deploy.yml

执行
```bash
$ ansible-playbook deploy.yml
```

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