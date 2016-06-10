# Role语句




比include更强大的代码重用机制。一个role可以包含vars_files, tasks, and handlers等等. 通常一个role定义了如何完成一个特定的功能,比如安装Webservers可以写成一个role, 安装Database可以写成一个role.

Ansible提供了一个分享role的平台, https://galaxy.ansible.com/, 在galaxy上可以找到别人写好的role.




## Role的目录结构


**在ansible中,通过遵循特定的目录结构,就可以实现对role的定义.**

下面的目录结构定义了两个role：一个是common，另外一个是webservers。

在site.yml，调用了这两个role。


<table>
    <tr>
        <td>
            role的目录结构
        </td>
        <td>
            site.yml中的使用
        </td>
    </tr>
    <tr>
        <td>
            <pre>
<code class='lang-yml'>
site.yml
roles/
   common/  
     files/
     templates/
     tasks/
     handlers/
     vars/
     defaults/
     meta/
   webservers/
     files/
     templates/
     tasks/
     handlers/
     vars/
     defaults/
     meta/
</code>
</pre>
        </td>
        <td>
            <pre>
<code>
---
- hosts: webservers
  roles:
     - common
     - webservers
</code>
</pre>

        </td>
    </tr>
</table>

## 带参数的Role



### 定义带参数的role

 定义一个带参数的role,名字是role_with_var,那么目录结构为
 
 ```
 main.yml
 roles
   role_with_var
     tasks
       main.yml
 ```
 
 在roles/rolw_with_var/tasks/main.yml中,直接使用定义的变量就可以了
 
 ```
 ---
 - name: use param
   debug: msg="{{ param }}"

```
### 使用带参数的role

那么在main.yml就可以用如下的方法使用role_with_var

```
---

- hosts: webservers
  roles:
    - { role: role_with_var, param: 'Call some_role for the 1st time' }
    - { role: role_with_var, param: 'Call some_role for the 2nd time' }
```

### 指定默认的参数

指定默认参数后,如果在调用时传参数了,那么就使用传入的参数值.如果调用的时候没有传参数,那么就使用默认的参数值.

指定默认参数很简单,以上面的role_with_var为例

```
main.yml
roles:
  role_with_var
    tasks
      main.yml
    vars
      main.yml
```
在roles/role_with_var/vars/main.yml中,使用yml的字典定义语法定义param的值,如下:
```
param: "I am the default value"
```

这样在main.yml中,下面两种调用方法都可以

```
---

- hosts: webservers
  roles:
    - role_with_var
    - { role: role_with_var, param: 'I am the value from external' }

```
更多的例子在https://github.com/shijingjing1221/ansible-first-book-examples/blob/master/role_vars.yml 中


## 与条件语句一起执行


下面的例子中,some_role只有在RedHat系列的server上才执行.
```
---

- hosts: webservers
  roles:
    - { role: some_role, when: "ansible_os_family == 'RedHat'" }

```


## 执行顺序

pre_tasks > role > tasks > post_tasks

```
---

- hosts: vm-rhel7-1
  user: root

  pre_tasks:
    - name: pre
      shell: echo 'hello'

  roles:
    - { role: some_role }

  tasks:
    - name: task
      shell: echo 'still busy'

  post_tasks:
    - name: post
      shell: echo 'goodbye'
```

看例子！！！

