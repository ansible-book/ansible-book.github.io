# Ansible用脚本管理主机

只有脚本才可以重用，避免总敲重复的代码。Ansible的脚本的名字叫Playbook，使用的是yml的格式。

注解：yml和json类似，是一种表示数据的格式。


##执行脚本playbook的方法


```
$ansible-palybook deploy.yml
```

##playbook的例子

deploy.yml的内容：

其中：

* **hosts**：为主机的IP，或者主机组名，或者关键字all
* **remote_user**: 以哪个用户身份执行。
* **vars**： 变量
* **tasks**: playbook的核心，定义顺序执行的action。每个action调用一个module。 action 语法： ```action: module options```
* **handers**： playbook的event，默认不会执行，在action里trigger才会执行。多次trigger只执行一次。


```yaml
---
- hosts: web
  vars:
    http_port: 80
    max_clients: 200
  remote_user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest
    
  - name: Write the configuration file
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
    notify:
    - restart apache

  - name: Write the default index.html file
    template: src=templates/index.html.j2 dest=/var/www/html/index.html

  - name: ensure apache is running
    service: name=httpd state=started
  handlers:
    - name: restart apache
      service: name=httpd state=restarted

```




---



不懂yml，没关系，上面的yml格式转化为json格式为：

提供json和yml互转的在线网站： http://www.json2yaml.com/
```json
[
  {
    "hosts": "web",
    "vars": {
      "http_port": 80,
      "max_clients": 200
    },
    "remote_user": "root",
    "tasks": [
      {
        "name": "ensure apache is at the latest version",
        "yum": "pkg=httpd state=latest"
      },
      {
        "name": "Write the configuration file",
        "template": "src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf",
        "notify": [
          "restart apache"
        ]
      },
      {
        "name": "Write the default index.html file",
        "template": "src=templates/index.html.j2 dest=/var/www/html/index.html"
      },
      {
        "name": "ensure apache is running",
        "service": "name=httpd state=started"
      }
    ],
    "handlers": [
      {
        "name": "restart apache",
        "service": "name=httpd state=restarted"
      }
    ]
  }
]
```