## template

如果你需要拷贝一个静态的文件，那么用copy module就够用了。但是如果你需要拷贝一个文件，并且根据需要部分内容，那么就需要用到template module啦。

比如安装apache后，你需要给节点拷贝一个测试页面index.html,index.html里面需要显示当前节点的主机名和IP,这时候就需要用到template。

index.html中，你需要指定你想替换的哪个部分，那么这个部分用变量来表示，template使用的是python的j2模版引擎，你不需要了解什么是j2，你只需要知道表量的表示法是```{{}}```就可以了。

### template文件语法

index.html具体应该怎么写呢，既然是tamplate文件，那么我们就加一个后缀提高可读性，index.html.j2。下面文件中使用了两个变量ansible_hostname和ansible_default_ipv4.address。

```
<html>
<title>Demo</title>
<body>
<div class="block" style="height: 99%;">
    <div class="centered">
        <h1>#46 Demo</h1>
        <p>Served by {{ ansible_hostname }} ({{ ansible_default_ipv4.address }}).</p>
    </div>
</div>
</body>
</html>
```

### 使用facts变量的template

在index.html.j2使用的两个变量ansible_hostname和ansible_default_ipv4.address都是facts变量，ansible会替我们搜索，直接可以在playbook中使用，当然也可以直接在template中使用。所以我们在写template语句中无需传入参数。

```
- name: Write the default index.html file
  template: src=templates/index.html.j2 dest=/var/www/html/index.html
```

### 使用普通变量的template

拷贝httpd.conf.j2拷贝到远程节点，根据需求设置默认的http端口，这时我们就需要用到普通的变量。

在httpd.conf.j2模版文件中，所有变量的是用方法都是一样的，都是是用```{{}}```:

```
ServerRoot "/etc/httpd"
...
Listen {{ http_port }}
...
```

普通变量不是在调用template的时候传进去，而是通过playbook中vars关键字定义。当然如果在playbook中可以直接使用的变量，都可以在template中，包括后面的章节会提到的定义在inventory中的变量。

```
- hosts: localhost
  vars:
    http_port: 8080
  remote_user: root
  tasks:

  - name: Write the configuration file
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
  ```

### 和copy module一样强大的功能

当然copy module不仅可以简单的拷贝文件到远程节点，还可以进行权限设置，文件备份，以及验证功能，那么这些功能，template同样具备。


```
- template:
    src: etc/ssh/sshd_config.j2
    dest: /etc/ssh/sshd_config.j2
    owner: root
    group: root
    mode: '0600'
    validate: /usr/sbin/sshd -t %s
    backup: yes
```
