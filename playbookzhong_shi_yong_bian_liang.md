# Playbook中使用变量

在Playbook中使用

```
- hosts: webservers
  vars:
      apache_config: labs.conf
  tasks:
      - name: deploy haproxy config
        template: src={{ apache_config }} dest=/etc/httpd/conf.d/{{ apache_config }}  
```

在Playbook中使用变量文件来使用

```
- hosts: webservers
  vars_files:
      - vars/server_vars.yml
  tasks:
      - name: deploy haproxy config
        template: src={{ apache_config }} dest=/etc/httpd/conf.d/{{ apache_config }}  
```

vars/server_vars.yml 内容

```
apache_config: labs.conf
```


## YAML的陷阱


下面的代码会报错，YAML值不能以{ 开头:
```
- hosts: app_servers
  vars:
      app_path: {{ base_path }}/22
```


要在{ 开始的值加上引号:

```
- hosts: app_servers
  vars:
       app_path: "{{ base_path }}/22"
```

