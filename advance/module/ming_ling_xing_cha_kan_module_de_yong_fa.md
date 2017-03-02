---
 layout: home
 title: 命令行查看module的用法
---

# 命令行查看module的用法

类似bash命令的man，ansible也可以通过命令行查看module的用法。命令是ansible-doc，语法如下:

```
ansible-doc module_name
```

core module可以在任何目录下执行。例如查看yum的用法：

```
ansible-doc yum
```

extra module必须在配置了extra module的目录下查看用法:

```
ansible-doc yum_repository
```



