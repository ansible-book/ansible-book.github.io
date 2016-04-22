# 主机目录管理


## 主机目录的配置文件




### 默认文件


/etc/ansible/hosts


### 修改主机目录的配置文件



/etc/ansible/ansible.cfg
```
...
inventory      = /etc/ansible/hosts
...
```




### 命令行中传递主机目录配置文件

```
$ ansible-playbook -i hosts site.yml
```
或者参数--inventory-file
```
$ ansible-playbook --inventory-file hosts site.yml
```


