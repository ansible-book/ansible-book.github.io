# 注册变量


把task的执行结果当作是一个变量的值，那么需要用的哦呵注册变量

```
---

- hosts: web

  tasks:

     - shell: ls
       register: result
       ignore_errors: True

     - shell: echo "{{ result.stdout }}"
       when: result.rc == 5

     - debug: msg="{{ result.stdout }}"
```