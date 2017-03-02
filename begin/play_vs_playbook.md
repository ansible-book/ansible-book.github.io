---
 layout: home
 title: Play vs Playbook
---

# Play vs Playbook

Playbook是指一个可被ansible执行的yml文件，一般的结构如下面的例子所示：

```
---
- hosts: web
  remote_user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest

```

其实在一个Playbook文件中还可以有针对两组server进行不同的操作，例如给web安装http服务器，和给lb安装mysql放在一个文件中：

```
---
#安装apache的play
- hosts: web
  remote_user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest

# 安装mysql server的play
- hosts: lb
  remote_user: root
  tasks:
  - name: ensure mysqld is at the latest version
    yum: pkg=mariadb state=latest
```

像上面例子中针对每一组server的所有操作就组成一个play，一般一个playbook中只包含一个play，所以不用太在意区分playbook与play。如果在有些ansible文档中提到play的概念，你知道是怎么回事就可以了。
