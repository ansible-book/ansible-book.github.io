# Ansible的主机目录管理

## 什么是主机目录管理？


告诉Ansible需要管理哪些主机。并且把这些主机根据你自己的需求分类。
可以根据用途分类，数据库节点，服务节点等
根据地点分类：中部，西部机房。


## 默认的主机目录文件：


/etc/ansible/hosts


## 例子



### 最简单的hosts：


```
192.168.1.50
aserver.example.org
bserver.example.org
```

###带分类的hosts:


```
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com

```