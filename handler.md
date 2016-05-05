# Handler




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
