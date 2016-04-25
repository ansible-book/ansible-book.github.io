# 注册变量


把task的执行结果当作是一个变量的值，那么需要用的哦呵注册变量

```
- hosts: web

  tasks:

     - shell: /usr/bin/foo
       register: foo_result
       ignore_errors: True

     - shell: /usr/bin/bar
       when: foo_result.rc == 5
```