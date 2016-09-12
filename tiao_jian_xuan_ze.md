# 条件语句When

类似于编程语言的if

## When语句

有时候用户有可能需满足特定条件才执行某一个特定的步骤。在某一个特定版本的系统上装包，或者只在磁盘空间满了的文件系统上执行清理操作一样。这些操作在Ansible上，使用`when`语句都非常简单.

主机为Debian Linux立刻关机

```
tasks:
  - name: "shutdown Debian flavored systems"
    command: /sbin/shutdown -t now
    when: ansible_os_family == "Debian"
```

根据action的执行结果，来决定接下来执行的action。

```
tasks:
  - command: /bin/false
    register: result
    ignore_errors: True
  - command: /bin/something
    when: result|failed
  - command: /bin/something_else
    when: result|success
  - command: /bin/still/something_else
    when: result|skipped
```

远程中的系统变量facts变量作为when的条件，用“\|int”还可以转换返回值的类型：

```
---
- hosts: web
  tasks:
    - debug: msg="only on Red Hat 7, derivatives, and later"
      when: ansible_os_family == "RedHat" and ansible_lsb.major_release|int >= 6
```

## 条件表达式

```
vars:
  epic: true
```

基本款

```
tasks:
    - shell: echo "This certainly is epic!"
      when: epic
```

否定款：

```
tasks:
    - shell: echo "This certainly isn't epic!"
      when: not epic
```

变量定义款

```
tasks:
    - shell: echo "I've got '{{ foo }}' and am not afraid to use it!"
      when: foo is defined

    - fail: msg="Bailing out. this play requires 'bar'"
      when: bar is not defined
```

数值表达款

```
tasks:
    - command: echo {{ item }}
      with_items: [ 0, 2, 4, 6, 8, 10 ]
      when: item > 5
```

## 与Include一起用

```
- include: tasks/sometasks.yml
  when: "'reticulating splines' in output"

```

## 与Role一起用

```
- hosts: webservers
  roles:
     - { role: debian_stock_config, when: ansible_os_family == 'Debian' }

```

