---
 layout: home
 title: 常用几个module的用法
---

# 常用几个module的用法
学习Linux操作系统，如果不懂一些基本的命令，那么真的没有办法用Linux。所以学习Ansible也非常有必要了解一些常用的module。

接下来介绍一些会在接下来的章节中用到的module，也是很常用的module。

调试和测试类的module

* ping - ping一下你的远程主机，如果可以通过ansible成功连接，那么返回pong
* debug - 用于调试的module，只是简单打印一些消息，有点像linux的echo命令。

文件类的module

* copy - 从本地拷贝文件到远程节点
* template - 从本地拷贝文件到远程节点，并进行变量的替换
* file - 设置文件的属性

linux上常用的操作

* user - 管理用户账户
* yum - red hat系linux上的包管理
* service - 管理服务
* firewalld - 管理防火墙中的服务和端口

执行Shell命令

* shell - 在节点上执行shell命令，支持$HOME和"&lt;", "&gt;", "\|", ";" and "&"
* command - 在远程节点上面执行命令，不支持$HOME和"&lt;", "&gt;", "\|", ";" and "&"

## ping

这个就最常用的测试一个节点有没有配置好ssh连接的module。不过它可不是简单像linux命令中ping一下远程节点，而是首先检查下能不能SSH登陆，然后再检查下远程节点的python版本漫不满足要求，如果都满足则会返回成功pong。

ping不需要传入任何参数。因为ping是测试节点连接是不是通的，所以一般在命令行中使用的时候比在playbook的脚本中多，下面是ping在命令行中的用法：

```
ansible servers -m ping
```

## debug

打印输出信息，和linux上的echo命令很像

### 通过参数msg定义打印的字符串

msg中可以嵌入变量,下面的例子中注入了系统变量，ansible在执行playbook之前会收集一些比较常用的系统变量，你在playbook中不需要定义直接就可以使用。

```
- debug:
    msg: "System \{\{ inventory_hostname \}\} has gateway \{\{ ansible_default_ipv4.gateway \}\}"

```

执行结果

```
TASK [debug] *******************************************************************
ok: [localhost] => {
    "msg": "System localhost has gateway 192.168.50.1"
}

```

### 通过参数var定义需要打印的变量

变量可以是系统变量，也可以是动态的执行结果，通过关键字regester注入到变量中。

* 打印系统的变量

```
  - name: Display all variables/facts known for a host
    debug:
      var: hostvars[inventory_hostname]["ansible_default_ipv4"]["gateway"]
```

  执行结果：

```
  TASK [Display part of variables/facts known for a host] ************************
  ok: [localhost] => {
      "hostvars[inventory_hostname][\"ansible_default_ipv4\"][\"gateway\"]": "192.168.50.1"
  }

```

* 打印动态注入的变量

```
  - shell: /usr/bin/uptime
    register: result

  - debug:
      var: result
```

执行结果

```
  TASK [command] *****************************************************************
  changed: [localhost]

  TASK [debug] *******************************************************************
  ok: [localhost] => {
      "result": {
          "changed": true,

          "cmd": "/usr/bin/uptime",
          "delta": "0:00:00.003212",
          "end": "2017-01-01 21:30:02.817443",
          "rc": 0,
          "start": "2017-01-01 21:30:02.814231",
          "stderr": "",
          "stdout": " 21:30:02 up 12:38,  8 users,  load average: 1.13, 1.31, 1.14",
          "stdout_lines": [
              " 21:30:02 up 12:38,  8 users,  load average: 1.13, 1.31, 1.14"
          ],
          "warnings": []
      }
  }

```

## copy

从当前的机器上copy静态文件到远程节点上，并且设置合理的文件权限。注意，copy module拷贝文件的时候，会先比较下文件的checksum，如果相同则不会拷贝，返回状态OK；如果不同才会拷贝，返回状态为changed。

### 设置文件权限

利用mode设置权限可以是用数字，当然也可以是符号的形式"u=rw,g=r,o=r"和"u+rw,g-wx,o-rwx"

```
- copy:
    src: /srv/myfiles/foo.conf
    dest: /etc/foo.conf
    owner: foo
    group: foo
    mode: 0644

```

### 备份结点上原来的文件

backup参数为yes的时候，如果发生了拷贝操作，那么会先备份下目标节点上的原文件。当两个文件相同时，不会进行拷贝操作，当然也没有必要备份啦。

```
- copy:
    src: sudoers
    dest: /tmp
    backup: yes

```

### 拷贝后的验证操作

validate参数接需要验证的命令。一般需要验证拷贝后的文件，所以%s可以指代拷贝后的文件。当copy module中加入了validate参数，不仅需要成功拷贝文件，还需要validate命令返回成功的状态，整个module的执行状态才是成功。

`visudo -cf /etc/sudoers`是验证sudoers文件有没有语法错误的命令。

```
- copy:
    src: /mine/sudoers
    dest: /etc/sudoers
    validate: 'visudo -cf %s'

```

## template

如果你需要拷贝一个静态的文件，那么用copy module就够用了。但是如果你需要拷贝一个文件，并且根据需要部分内容，那么就需要用到template module啦。

比如安装apache后，你需要给节点拷贝一个测试页面index.html,index.html里面需要显示当前节点的主机名和IP,这时候就需要用到template。

index.html中，你需要指定你想替换的哪个部分，那么这个部分用变量来表示，template使用的是python的j2模版引擎，你不需要了解什么是j2，你只需要知道表量的表示法是`\{\{\}\}`就可以了。

### template文件语法

index.html具体应该怎么写呢，既然是tamplate文件，那么我们就加一个后缀提高可读性，index.html.j2。下面文件中使用了两个变量ansible\_hostname和ansible\_default\_ipv4.address。

```
<html>
<title>Demo</title>
<body>
<div class="block" style="height: 99%;">
    <div class="centered">
        <h1>#46 Demo</h1>
        <p>Served by \{\{ ansible_hostname \}\} (\{\{ ansible_default_ipv4.address \}\}).</p>
    </div>
</div>
</body>
</html>
```

### 使用facts变量的template

在index.html.j2使用的两个变量ansible\_hostname和ansible\_default\_ipv4.address都是facts变量，ansible会替我们搜索，直接可以在playbook中使用，当然也可以直接在template中使用。所以我们在写template语句中无需传入参数。

```
- name: Write the default index.html file
  template: src=templates/index.html.j2 dest=/var/www/html/index.html

```

### 使用普通变量的template

拷贝httpd.conf.j2拷贝到远程节点，根据需求设置默认的http端口，这时我们就需要用到普通的变量。

在httpd.conf.j2模版文件中，所有变量的是用方法都是一样的，都是是用`\{\{\}\}`:

```
ServerRoot "/etc/httpd"
...
Listen \{\{ http_port \}\}
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

## file

file module设置远程值机上的文件、软链接（symlinks）和文件夹的权限，也可以用来创建和删除他们。

### 改变文件的权限

当然mode参数可以直接赋值数字权限（必须以0开头），也可以赋值，还可以用来增加和删除权限。具体的写法见下面的代码：

```
- file:
    path: /etc/foo.conf
    owner: foo
    group: foo
    mode: 0644
    #mode: "u=rw,g=r,o=r"
    #mode: "u+rw,g-wx,o-rwx"
```

### 创建文件的软链接

注意这里面的src和sest参数的含义是和copy module不一样的，file module里面所操作的文件都是远程节点上的文件。

```
- file:
    src: /file/to/link/to
    dest: /path/to/symlink
    owner: foo
    group: foo
    state: link

```

### 创建一个新文件

像touch命令一样创建一个新文件

```
- file:
    path: /etc/foo.conf
    state: touch
    mode: "u=rw,g=r,o=r"

```

### 创建新的文件夹

```
# create a directory if it doesn't exist
- file:
    path: /etc/some_directory
    state: directory
    mode: 0755
```

## user

user module可以增、删、改Linux远程节点的用户账户，并为其设置账户的属性。

### 增加账户

* 增加账户johnd，并且设置uid为1040，设置用户的primary group为admin

```
  - user:
      name: johnd
      comment: "John Doe"
      uid: 1040
      group: admin
```

* 创建账户james，并为james用户额外添加两个group

```
  - user:
      name: james
      shell: /bin/bash
      groups: admins,developers
      append: yes
```

### 删除账户

删除账户johnd

```
- user:
    name: johnd
    state: absent
    remove: yes

```

### 修改账户的属性

* 为账户jsmith创建一个 2048-bit的SSH key，放在~jsmith/.ssh/id\_rsa

```
  - user:
      name: jsmith
      generate_ssh_key: yes
      ssh_key_bits: 2048
      ssh_key_file: .ssh/id_rsa
```

* 为用户添加过期时间：

```
  - user:
      name: james18
      shell: /bin/zsh
      groups: developers
      expires: 1422403387
```

## yum

yum module是用来管理red hat系的Linux上的安装包的，包括RHEL，CentOS，和fedora 21一下的版本。fedora从版本22开始就使用dnf，推荐使用dnf module来进行安装包的操作。

### 从yum源上安装和删除包

* 安装最新版本的包，如果已经安装了老版本，那么会更新到最新的版本：

```
  - name: install the latest version of Apache
    yum:
      name: httpd
      state: latest

```

* 安装指定版本的包

```
  - name: install one specific version of Apache
    yum:
      name: httpd-2.2.29-1.4.amzn1
      state: present

```

* 删除httpd包

```
  - name: remove the Apache package
    yum:
      name: httpd
      state: absent

```

* 从指定的repo testing中安装包

```
  - name: install the latest version of Apache from the testing repo
    yum:
      name: httpd
      enablerepo: testing
      state: present
```

### 从yum源上安装一组包

```
- name: install the 'Development tools' package group
  yum:
    name: "@Development tools"
    state: present

- name: install the 'Gnome desktop' environment group
  yum:
    name: "@^gnome-desktop-environment"
    state: present
```

### 从本地文件中安装包

```
- name: install nginx rpm from a local file
  yum:
    name: /usr/local/src/nginx-release-centos-6-0.el6.ngx.noarch.rpm
    state: present

```

### 从URL中安装包

```
- name: install the nginx rpm from a remote repo
  yum:
    name: http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
    state: present

```

## service

管理远程节点上的服务，什么是服务呢，比如httpd、sshd、nfs、crond等。

### 开、关、重起、重载服务

* 开httpd服务

```
  - service:
      name: httpd
      state: started
```

* 关服务

```
  - service:
      name: httpd
      state: stopped
```

* 重起服务

```
  - service:
      name: httpd
      state: restarted
```

* 重载服务

```
  - service:
      name: httpd
      state: reloaded
```

### 设置开机启动的服务

```
- service:
    name: httpd
    enabled: yes
```

### 启动网络服务下的接口

```
- service:
    name: network
    state: restarted
    args: eth0

```

## firewalld

firewalld module为某服务和端口添加firewalld规则。firewalld中有正在运行的规则，和永久的规则，firewalld module都支持。

firewalld要求远程节点上的firewalld版本在0.2.11以上。

### 为服务添加firewalld规则

```
- firewalld:
    service: https
    permanent: true
    state: enabled

```

```
- firewalld:
    zone: dmz
    service: http
    permanent: true
    state: enabled
```

### 为端口号添加firewalld规则

```
- firewalld:
    port: 8081/tcp
    permanent: true
    state: disabled

```

```
- firewalld:
    port: 161-162/udp
    permanent: true
    state: enabled

```

### 其它复杂的firewalld规则

```
- firewalld:
    rich_rule: 'rule service name="ftp" audit limit value="1/m" accept'
    permanent: true
    state: enabled

```

```
- firewalld:
    source: 192.0.2.0/24
    zone: internal
    state: enabled

```

```
- firewalld:
    zone: trusted
    interface: eth2
    permanent: true
    state: enabled
```

```
- firewalld:
    masquerade: yes
    state: enabled
    permanent: true
    zone: dmz
```

## shell

通过/bin/sh在远程节点上执行命令。如果一个操作你可以通过Module yum，copy操作实现，那么你不要使用shell或者command这样通用的命令module。因为通用的命令module不会根据具体操作的特点进行status的判断，所以当没有必要再重新执行的时候，它还是要重新执行一遍。

### 支持$home，支持$HOME和"&lt;", "&gt;", "\|", ";" and "&"。

* 支持$home

```
  - name: test $home
    shell: echo "Test1" > ~/tmp/test1
```
* 支持&&

```
  - shell: service jboss start && chkconfig jboss on
```

* 支持&gt;&gt;

```
  - shell: echo foo >> /tmp/testfoo
```

### 调用脚本

* 调用脚本

```
  - shell: somescript.sh >> somelog.txt
```

* 执行命令前，改变工作目录

```
  - shell: somescript.sh >> somelog.txt
    args:
      chdir: somedir/
```

* 在执行命令前改变工作目录，且仅在文件somelog.txt不存在时才执行该action。

```
  - shell: somescript.sh >> somelog.txt
    args:
      chdir: somedir/
      creates: somelog.txt

```

* 指定用bash运行命令

```
  - shell: cat < /tmp/\*txt
    args:
      executable: /bin/bash
```

## Command

在远程节点上执行命令。和Shell Module类似，不过不支持$HOME and operations like "&lt;", "&gt;", "\|", ";" and "&"。

### 和Shell一样

* 像Shell一样调用单条命令

```
  - command: /sbin/shutdown -t now
```

* 和Shell一样，可以在执行命令钱改变目录，并检查文件database不存在时再执行

```
  - command: /usr/bin/make_database.sh arg1 arg2
    args:
      chdir: somedir/
      creates: /path/to/database

```

### 和Shell不一样

* 与Shell不同，多了一个传参方式：

```
  - command: /usr/bin/make_database.sh arg1 arg2 creates=/path/to/database

```
* 不支持&&和&gt;&gt;

  下面的写法，没有办法创建~/tmp/test3和~/tmp/test4的

```
  - name: test $home
    command: echo "test3" > ~/tmp/test3 && echo "test4" > ~/tmp/test4

```



