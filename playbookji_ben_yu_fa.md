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





 

