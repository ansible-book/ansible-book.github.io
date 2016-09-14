# Ansible的 Host Inventory 

## 什么是 Host Inventory （ 主机目录 、主机清单）？

 Host Inventory 是配置文件，用来告诉Ansible需要管理哪些主机。并且把这些主机根据按需分类。

可以根据用途分类：数据库节点，服务节点等；根据地点分类：中部，西部机房。

## Host Inventory 配置文件：

默认的文件是：
**\/etc\/ansible\/hosts**

可以修改为其它的文件，下一章Ansible进阶中介绍。

## 例子

### 最简单的hosts文件：

```ini
192.168.1.50
aserver.example.org
bserver.example.org
```

### 带分类的hosts文件:

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

