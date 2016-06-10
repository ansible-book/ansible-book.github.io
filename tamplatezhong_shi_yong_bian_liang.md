# 文件模板中使用的变量


文件模板即template。Ansible使用的文件是python的一个j2的模板。

## template变量的定义
在playbook中定义的变量，可以直接在template中使用。

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
    firewalld: port={{ http_port }}/tcp permanent=true state=enabled immediate=yes

  handlers:
    - name: restart apache
      service: name=httpd state=restarted

```
## template变量的使用

在template index.html.j2中可以直接使用系统变量和用户自定义的变量

* 系统变量 ** \{\{ ansible_hostname \}\} **, ** \{\{ ansible_default_ipv4.address \}\} **

* 用户自定义的变量 ** \{\{ defined_name \}\} **

index.html.j2文件：  
```
<html>
<title>#46 Demo</title>

<!--
http://stackoverflow.com/questions/22223270/vertically-and-horizontally-center-a-div-with-css
http://css-tricks.com/centering-in-the-unknown/
http://jsfiddle.net/6PaXB/
-->

<style>.block {text-align: center;margin-bottom:10px;}.block:before {content: '';display: inline-block;height: 100%;vertical-align: middle;margin-right: -0.25em;}.centered {display: inline-block;vertical-align: middle;width: 300px;}</style>

<body>
<div class="block" style="height: 99%;">
    <div class="centered">
        <h1>#46 Demo {{ defined_name }}</h1>
        <p>Served by {{ ansible_hostname }} ({{ ansible_default_ipv4.address }}).</p>
    </div>
</div>
</body>
</html>


```