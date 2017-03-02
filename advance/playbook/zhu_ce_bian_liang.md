---
 layout: home
 title: 把Task的执行结果当做变量(注册变量)
---

# 把Task的执行结果当做变量(注册变量)

把task的执行结果也可以作为一个变量值。这个时候就需要用到“注册变量”，将执行结果注册到一个变量中，待后面的action使用：

```
---

- hosts: web

  tasks:

     - shell: ls
       register: result
       ignore_errors: True

     - shell: echo "\{\{ result.stdout \}\}"
       when: result.rc == 5

     - debug: msg="\{\{ result.stdout \}\}"

```

注册变量经常和debug module一起使用，这样可以得到更多action的输出信息，帮助用户调试。

