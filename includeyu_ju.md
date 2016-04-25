# Include语句

Include语句的功能，基本的代码重用机制。重用tasks

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
