# 主机目录(Host Inventory)


什么叫主机目录管理,告诉ansible需要管理哪些server，和server的分类和分组信息。可以根据你自己的需要根据地域分类，也可以按照功能的不同分类。

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


