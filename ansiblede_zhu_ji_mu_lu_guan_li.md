# Ansible的主机目录管理

## 什么是主机目录？


主机目录是配置文件，用来告诉Ansible需要管理哪些主机。并且把这些主机根据按需分类。

可以根据用途分类：数据库节点，服务节点等；根据地点分类：中部，西部机房。


## 主机目录配置文件：

默认的文件是：
**/etc/ansible/hosts**
可以修改，下一章介绍。


## 例子



### 最简单的hosts：


```ini
192.168.1.50
aserver.example.org
bserver.example.org
```

###带分类的hosts:


```ini
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com

```