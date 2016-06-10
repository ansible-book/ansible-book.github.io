# Include语句

Include语句的功能，基本的代码重用机制。主要重用tasks。

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


## 高级用法-加参数


加参数
```
tasks:
  - include: tasks/firewall.yml port=80
  - include: tasks/firewall.yml port=3260
  - include: tasks/firewall.yml port=423
```



还可以这样加：
```
tasks:

  - include: wordpress.yml
    vars:
        wp_user: timmy
        ssh_keys:
          - keys/one.txt
          - keys/two.txt
```

还可以简写成：
```
tasks:
 - { include: wordpress.yml, wp_user: timmy, ssh_keys: [ 'keys/one.txt', 'keys/two.txt' ] }
```

在handlers里面加include
```
handlers:
  - include: handlers/handlers.yml
```

在全局加include时，tasks和handlers不能有include
```
- name: this is a play at the top level of a file
  hosts: all
  remote_user: root

  tasks:

  - name: say hi
    tags: foo
    shell: echo "hi..."

- include: load_balancers.yml
- include: webservers.yml
- include: dbservers.yml
```

## include里面的handlers在外面调用不了
不知道为什么有一处文档里面写可以调用。文档下面两个地方提到include里面的handlers，但是两处是矛盾的:
* hander的文档写不能调用
http://docs.ansible.com/ansible/playbooks_intro.html
* include的文档写能调用
http://docs.ansible.com/ansible/playbooks_roles.html#task-include-files-and-encouraging-reuse

通过下面的例子实测后，是不能调用include里面的handler的。

```
---
- hosts: lb
  user: root
  gather_facts: no
  vars:
      random_number: "{{ 10000 | random }}"
  tasks:
  - name: Copy the /etc/hosts to /tmp/hosts.{{ random_number }}
    copy: src=/etc/hosts dest=/tmp/hosts.{{ random_number }}
    notify:
      - restart apache
      - restart apache in handlers


  handlers:
    - include: handlers/handlers.yml
    - name: restart apache
      debug: msg="This is the handler restart apache"

```