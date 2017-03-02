---
 layout: home
 title: 文件模板中使用的变量
---

# 文件模板中使用的变量
template module在Ansible中很常用，而它在使用的时候又没有显式的指定template文件中的值，有时候用户会对template文件中使用的变量感到困惑，所以在这里再次强调下。

## template变量的定义

在playbook中定义的变量，可以直接在template中使用，同时facts变量也可以直接在template中使用，当然也包含在inventory里面定义的host和group变量。只要是在playbook中可以访问的变量，都可以在template文件中使用。

下面的playbook脚本中使用了template module来拷贝文件index.html.j2，并且替换了index.html.j2中的变量为playbook中定义变量值。

```
---
- hosts: web
  vars:
    http_port: 80
    defined_name: "Hello My name is Jingjng"
  remote_user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest

  - name: Write the configuration file
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
    notify:
    - restart apache

  - name: Write the default index.html file
    template: src=templates/index2.html.j2 dest=/var/www/html/index.html

  - name: ensure apache is running
    service: name=httpd state=started
  - name: insert firewalld rule for httpd
    firewalld: port=\{\{ http_port \}\}/tcp permanent=true state=enabled immediate=yes

  handlers:
    - name: restart apache
      service: name=httpd state=restarted

```

## template变量的使用

Ansible模版文件使用变量的语法是Python的template语言[Jinja2](http://jinja.pocoo.org/docs/dev/templates/#builtin-filters)。

在下面的例子template index.html.j2中，直接使用了以下变量：

* 系统变量 ** \{\{ ansible\_hostname \}\} **, ** \{\{ ansible\_default\_ipv4.address \}\} **

* 用户自定义的变量 ** \{\{ defined\_name \}\} **

index.html.j2文件：

```
<html>
<title>Demo</title>
<body>
<div class="block" style="height: 99%;">
    <div class="centered">
        <h1>#46 Demo \{\{ defined_name \}\}</h1>
        <p>Served by \{\{ ansible_hostname \}\} (\{\{ ansible_default_ipv4.address \}\}).</p>
    </div>
</div>
</body>
</html>
```



