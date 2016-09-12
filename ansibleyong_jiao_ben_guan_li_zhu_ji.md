# Ansible用脚本管理主机

只有脚本才可以重用，避免总敲重复的代码。Ansible脚本的名字叫Playbook，使用的是YAML的格式，文件 以yml结尾。

注解：YAML和JSON类似，是一种表示数据的格式。

## 执行脚本playbook的方法

```
$ansible-palybook deploy.yml
```

## playbook的例子

deploy.yml的功能为web主机部署apache, 其中包含以下部署步骤：

1. 安装apache包；
2. 拷贝配置文件httpd，并保证拷贝文件后，apache服务会被重启；
3. 拷贝默认的网页文件index.html；
4. 启动apache服务；

playbook deploy.yml包含下面几个关键字，每个关键字的含义：

* **hosts**：为主机的IP，或者主机组名，或者关键字all
* **remote\_user**: 以哪个用户身份执行。
* **vars**： 变量
* **tasks**: playbook的核心，定义顺序执行的动作action。每个action调用一个ansbile module。

* > action 语法： `module： module_parameter=module_value`

* > 常用的module有yum、copy、template等，module在ansible的作用，相当于bash脚本中yum，copy这样的命令。下一节会介绍。

* **handers**： 是playbook的event，默认不会执行，在action里触发才会执行。多次触发只执行一次。


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

不懂yml，没关系，上面的deploy.yml格式转化为json格式为：

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

提供json和yml互转的在线网站： [http:\/\/www.json2yaml.com\/](http://www.json2yaml.com/)

