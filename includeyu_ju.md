# Include语句

Include语句的功能，基本的代码重用机制。重用tasks

## 普通用法


像其它语言的Include语句一样，直接Include：
<div style="-webkit-column-count:2; -moz-column-count: 2; column-count: 2; -webkit-column-rule: 1px dotted #e0e0e0; -moz-column-rule: 1px dotted #e0e0e0; column-rule: 1px dotted #e0e0e0;">
    <div style="display: inline-block;">
    The foo.yml file:
        <pre>
<code>
---
# possibly saved as tasks/foo.yml

- name: placeholder foo
  command: /bin/foo

- name: placeholder bar
  command: /bin/bar
</code>
    </pre>
    </div>
    <div style="display: inline-block;">
    The main file main.yml:
       <pre>
<code>
---
tasks:

  - include: tasks/foo.yml




</code>
      </pre>
    </div>
</div>


## 高级用法-加参数


加参数
```
tasks:
  - include: wordpress.yml wp_user=timmy
  - include: wordpress.yml wp_user=alice
  - include: wordpress.yml wp_user=bob
```

还可以简写成：
```
tasks:
 - { include: wordpress.yml, wp_user: timmy, ssh_keys: [ 'keys/one.txt', 'keys/two.txt' ] }
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

在handlers里面加include
```
handlers:
  - include: handlers/handlers.yml
```

在全局加include，但是tasks和handlers不能有include
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
