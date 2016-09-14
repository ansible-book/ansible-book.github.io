# ansible的配置

## 可以配置什麼?

从基本的，主机目录文件"inventory"，extra module放置路径"library" ，远程主机的临时文件位置" remote\_tmp" ，管理节点上临时文件的位置"local\_tmp"

```
inventory      = /etc/ansible/hosts
library        = /usr/share/my_modules/
remote_tmp     = $HOME/.ansible/tmp
local_tmp      = $HOME/.ansible/tmp
```

到高级的，连接端口号"accelerate\_port"，超时时间等。

```
accelerate_port = 5099
accelerate_timeout = 30
accelerate_connect_timeout = 5.0
```

看一个完整的anbile配置文件例子，就能基本了解到ansible都能配置什么了:

[https:\/\/raw.githubusercontent.com\/ansible\/ansible\/devel\/examples\/ansible.cfg](https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg)

对ansible配置文件里面的关键字不能完整理解，还可以参考关键词解释列表:

[http:\/\/docs.ansible.com\/ansible\/intro\_configuration.html\#explanation-of-values-by-section](http://docs.ansible.com/ansible/intro_configuration.html#explanation-of-values-by-section)

## anbile配置文件的优先级

ansible的默认配置文件是\/etc\/ansible\/ansible.cfg。其实ansible会按照下面的顺序查找配置文件，并**使用第一个**发现的配置文件。

```
* ANSIBLE_CONFIG (an environment variable)
* ansible.cfg (in the current directory)
* .ansible.cfg (in the home directory)
* /etc/ansible/ansible.cfg
```

Ansible1.5以前的版本顺序为：

```
* ansible.cfg (in the current directory)
* ANSIBLE_CONFIG (an environment variable)
* .ansible.cfg (in the home directory)
* /etc/ansible/ansible.cfg
```

