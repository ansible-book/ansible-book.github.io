# Playbook基本语法


## 执行Playbook语法


```bash
$ ansible-playbook deploy.yml
```
查看输出的细节


```
ansible-playbook playbook.yml --list-hosts
```

查看该脚本影响哪些hosts

```
ansible-playbook playbook.yml --list-hosts
```

并行执行脚本

```
ansible-playbook playbook.yml -f 10
```


## 完整的deploy.yml示例



```yml
---
- hosts: webservers
  vars:
    http_port: 80
    max_clients: 200
  user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest
  - name: write the apache config file
    template: src=/srv/httpd.j2 dest=/etc/httpd.conf
    notify:
    - restart apache
  - name: ensure apache is running
    service: name=httpd state=started
  handlers:
    - name: restart apache
      service: name=httpd state=restarted
```

## 主机和用户



| key | 含义  |
| -- | -- |
| **hosts** | 为主机的IP，或者主机组名，或者关键字all |
|**user** | 在远程以哪个用户身份执行。 |
| **become** | 切换成其它用户身份执行，值为yes或者no |
| **become_method** | 与became一起用，指可以为‘sudo’/’su’/’pbrun’/’pfexec’/’doas’ |
| **become_user** | 与bacome_user一起用，可以是root或者其它用户名 |

脚本里用became的时候，执行的playbook的时候可以加参数--ask-become-pass

```ansible-playbook deploy.yml --ask-become-pass```



## 任务列表

* tasks是从上到下顺序执行，如果中间发生错误，那么整个playbook会中之。你可以改修文件后，再重新执行。
* 每一个task的对module的一次调用。使用不同的参数，变量。
* 每一个task必须有一个name属性，这个是供人读的，然后会再命令行里面输出。

task的基本写法

```
tasks:
  - name: make sure apache is running
    service: name=httpd state=running
```
 
参数太长可以分隔到多行
 
 ```
 tasks:
  - name: Copy ansible inventory file to client
    copy: src=/etc/ansible/hosts dest=/etc/ansible/hosts
            owner=root group=root mode=0644
 ```
或者用yml的字典作为参数

```
 tasks:
  - name: Copy ansible inventory file to client
    copy: 
      src: /etc/ansible/hosts 
      dest: /etc/ansible/hosts
      owner: root
      group: root 
      mode: 0644
```
 
## Handlers



### 在所有的任务里表执行之后执行，如果有多个task调用同一个handler,那么只执行一次。



在下面的例子里apache只执行一次

https://github.com/shijingjing1221/ansible-first-book-examples/blob/master/handlers_state.yml


```
---
- hosts: lb
  remote_user: root
  vars:
      random_number1: "{{ 10000 | random }}"
      random_number2: "{{ 10000000000 | random }}"
  tasks:
  - name: Copy the /etc/hosts to /tmp/hosts.{{ random_number1 }}
    copy: src=/etc/hosts dest=/tmp/hosts.{{ random_number1 }}
    notify:
      - call in every action
  - name: Copy the /etc/hosts to /tmp/hosts.{{ random_number2 }}
    copy: src=/etc/hosts dest=/tmp/hosts.{{ random_number2 }}
    notify:
      - call in every action

  handlers:
  - name: call in every action
    debug: msg="call in every action, but execute only one time"

```

## 只有当TASKS的执行状态是changed时,才会执行handler



下面的脚本执行两次,执行结果是不同的:

第一次执行是,tasks的状态都是changed,会触发两次handler

第二次执行是,第一个task /tmp/hosts的状态是OK,那么不会触发handlers"call by /tmp/hosts",
第二个task的状态是changed,才会触发handler"call by /tmp/hosts.random_number"

https://github.com/shijingjing1221/ansible-first-book-examples/blob/master/handlers_execution_time.yml

```
---
- hosts: lb
  remote_user: root
  vars:
      random_number: "{{ 10000 | random }}"
  tasks:
  - name: Copy the /etc/hosts to /tmp/hosts
    copy: src=/etc/hosts dest=/tmp/hosts
    notify:
      - call by /tmp/hosts
  - name: Copy the /etc/hosts to /tmp/hosts.{{ random_number }}
    copy: src=/etc/hosts dest=/tmp/hosts.{{ random_number }}
    notify:
      - call by /tmp/hosts.random_number

  handlers:
  - name: call by /tmp/hosts
    debug: msg="call first time"
  - name: call by /tmp/hosts.random_number
    debug: msg="call by /tmp/hosts.random_number"

  
```

