# Playbook中使用变量



```
- hosts: webservers
  vars:
      apache_config: labs.conf
  tasks:
    - name: deploy haproxy config
      template: src={{ apache_config }} dest=/etc/httpd/conf.d/{{ apache_config }}  
```