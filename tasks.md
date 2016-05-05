# Tasks

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

