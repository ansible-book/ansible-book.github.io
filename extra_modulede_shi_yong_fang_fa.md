---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home
---
# Extra module的使用方法


使用Exra module需要进行下面的配置，就可以在命令行或者是playbook中使用了。配置后extra module使用方法和core module的使用方法是一样的。


**1 下载ansible module extra项目**

```
git clone https://github.com/ansible/ansible-modules-extras.git
```

我的一下在/home/jshi/software/目录下了，后面会用到。

**2 修改配置文件或者环境变量**

**方法1 - 改ansible默认配置文件/etc/ansible/ansible.cfg**

修改ansible配置文件/etc/ansible/ansible.cfg, 添加一行  
```
library	= /home/jshi/software/ansible-modules-extras/
```

**方法2 - 改ansible当前目录下配置文件ansible.cfg**

改ansible playbook当前的目录下的配置文件ansible.cfg，那么只**对当前目录的playbook生效**。对所有其它目录，包括父目录和子目录的playbook都不生效。  
```
library/ansible-modules-extras
ansible.cfg
use_extra_module.yml
subfolder/use_extra_module_will_throw_error.yml
```

在当前目录的ansible.cfg中，可以使用相对路径：  
```
library = library/ansible-modules-extras/
```


**方法3 - 该环境变量**

```
export ANSIBLE_LIBRARY=/project/demo/demoansible/library/ansible-module-extras
```

如果需要在重启后生效，那么放在~/.bashrc中声明ANSIBLE_LIBRARY变量：

```
$ echo >>~/.bashrc <<EOF

export ANSIBLE_LIBRARY=/project/demo/demoansible/library/ansible-module-extras

EOF

$ source ~/.bashrc
```




