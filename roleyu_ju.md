# Role语句




强大的代码重用机制。重用包括vars_files, tasks, and handlers.

分享role的平台: https://galaxy.ansible.com/


## 基本的Role

下面的目录结构定义了两个role,一个是common,另外一个是webservers.
在site.yml,调用了这两个role

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




### 使用带参数的role



```
---

- hosts: webservers
  roles:
    - { role: role_with_var, param: 'Call some_role for the 1st time' }
    - { role: role_with_var, param: 'Call some_role for the 2nd time' }
```


## 与条件语句一起执行



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

