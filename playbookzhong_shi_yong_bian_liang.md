# Playbook中使用的变量

在Playbook中使用，需要用\{\{ \}\}引用以来即可：

```
- hosts: webservers
  vars:
      apache_config: labs.conf
  tasks:
      - name: deploy haproxy config
        template: src={{ apache_config }} dest=/etc/httpd/conf.d/{{ apache_config }}  
```

在Playbook中使用变量文件定义变量

```
- hosts: webservers
  vars_files:
      - vars/server_vars.yml
  tasks:
      - name: deploy haproxy config
        template: src={{ apache_config }} dest=/etc/httpd/conf.d/{{ apache_config }}  
```

变量文件vars/server_vars.yml的内容为：

```
apache_config: labs.conf
```


## YAML的陷阱


YAML的陷阱是YAML和Ansible Playbook的变量语法不能在一起好好工作了。这里特指冒号后面的值不能以"{ "开头。

下面的代码会报错:
```
- hosts: app_servers
  vars:
      app_path: {{ base_path }}/22
```


解决办法：要在"{ "开始的值**加上引号**:

```
- hosts: app_servers
  vars:
       app_path: "{{ base_path }}/22"
```

