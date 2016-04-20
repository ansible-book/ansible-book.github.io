# 分组管理文件

假设inventory文件为/etc/ansible/hosts，那么相关的hosts和group变量可以放在下面的目录结构下

```ini
/etc/ansible/group_vars/raleigh # can optionally end in '.yml', '.yaml', or '.json'
/etc/ansible/group_vars/webservers
/etc/ansible/host_vars/foosball
```

/etc/ansible/group_vars/raleigh 文件内容可以为

```
---
ntp_server: acme.example.org
database_server: storage.example.org
```

ansible会读取这个目录下面所有文件的内容
```
/etc/ansible/group_vars/raleigh/db_settings
/etc/ansible/group_vars/raleigh/cluster_settings
```