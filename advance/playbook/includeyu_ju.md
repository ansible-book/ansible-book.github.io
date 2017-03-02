---
 layout: home
 title: 重用单个playbook文件(include语句)
---

# 重用单个playbook文件(include语句)
Include语句的功能，基本的代码重用机制。主要重用tasks。同时Include可将tasks分割成多个文件，避免Playbook过于臃肿，使用户更关注于整体的架构，而不是实现的细节上。

## 普通用法

像其它语言的Include语句一样，直接Include：

```
---
# possibly saved as tasks/firewall_httpd_default.yml

  - name: insert firewalld rule for httpd
    firewalld: port=80/tcp permanent=true state=enabled immediate=yes
```

main.yml文件中调用include的方法:

```
tasks:
    - include: tasks/firewall_httpd_default.yml

```

## 高级用法-使用参数

### include文件中还可以定义参数

被include的文件tasks/firewall_httpd_default.yml中，使用```\{\{ port \}\}```定义了一个名字为port的参数。

```
---
  - name: insert firewalld rule for httpd
    firewalld: port=\{\{ port \}\}/tcp permanent=true state=enabled immediate=yes

```

### 传参数的各种方法

* 在执行的playbook传参数，可以加在行尾，使用空格分隔：

```
  tasks:
    - include: tasks/firewall.yml port=80
    - include: tasks/firewall.yml port=3260
    - include: tasks/firewall.yml port=423

```

* 还可以使用yml的字典传参数：

```
  tasks:

    - include: wordpress.yml
      vars:
          wp_user: timmy
          ssh_keys:
            - keys/one.txt
            - keys/two.txt
```

* 还可以把一条task简写成成一个类JSON的形式传参数：

```
  tasks:
   - { include: wordpress.yml, wp_user: timmy, ssh_keys: [ 'keys/one.txt', 'keys/two.txt' ] }

```

* 当然在playbook中已经定义了的参数，就不需要再显示传入值了，可以直接写成下面的：

```
  ---
  - hosts: lb
    vars:
      port: 3206
    remote_user: root
    tasks:
      - include: tasks/firewall.yml
```


## include语句相关的那些坑

* 在handlers里面加include

  handlers中加入include语句的语法如下：

```
  handlers:
    - include: handlers/handlers.yml

```

  然而为什么有一处文档里面写可以调用。文档下面两个地方提到include里面的handlers，但是两处是矛盾的:

  * hander的文档写不能调用
    [http://docs.ansible.com/ansible/playbooks_intro.html](http://docs.ansible.com/ansible/playbooks_intro.html)
  * include的文档写能调用
    [http://docs.ansible.com/ansible/playbooks_roles.html#task-include-files-and-encouraging-reuse](http://docs.ansible.com/ansible/playbooks_roles.html#task-include-files-and-encouraging-reuse)

  通过下面的例子实测后，基于ansible1.9是不能调用include里面的handler的，不过基于ansible2.0+是可以调用include里面的handler的。所以在使用的时候注意你安装的ansible版本。

```
  ---
  - hosts: lb
    user: root
    gather_facts: no
    vars:
        random_number: "\{\{ 10000 | random \}\}"
    tasks:
    - name: Copy the /etc/hosts to /tmp/hosts.\{\{ random_number \}\}
      copy: src=/etc/hosts dest=/tmp/hosts.\{\{ random_number \}\}
      notify:
        - restart apache
        - restart apache in handlers


    handlers:
      - include: handlers/handlers.yml
      - name: restart apache
        debug: msg="This is the handler restart apache"
```
  
* Ansible允许的全局（或者叫plays）加include

  然而这种使用方式并不推荐，首先它不支持嵌入include，而且很多playbook的参数也不可以使用。

```
  - name: this is a play at the top level of a file
    hosts: all
    remote_user: root

    tasks:

    - name: say hi
      tags: foo
      shell: echo "hi..."
  # 全局include，或者叫playbook include
  - include: load_balancers.yml
  - include: webservers.yml
  - include: dbservers.yml

```

* 为了使include功能更强大，在每个新出的ansible都会添加新的一些功能，例如在2.0中添加了include动态名字的yml，然而这样的用法有很多的限制，不够成熟，可能在更新的ansible又去掉了，学习和维护成本很高。所以需要使用更灵活的重用机制时，建议用下一节介绍的role。
