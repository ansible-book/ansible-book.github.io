# 把运行结果当做变量使用-注册变量


把task的执行结果当作是一个变量的值也是可以的。这个时候就需要用到注册变量，将执行结果注册到一个变量中，待后面的action使用：

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