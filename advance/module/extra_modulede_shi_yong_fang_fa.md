---
 layout: home
 title: Extra module的使用方法
---

# Extra module的使用方法
# Extra module的使用方法

使用Exra module需要进行下面的配置，就可以在命令行playbook中使用了。配置后extra module使用方法和core module的使用方法是一样的。

\[注\]部分Extra module经过一段时间的测试，就会放到Core module。其实Ansible团队会一直致力于把成熟的长期使用没有问题的Module放入Core Module中，方便客户的使用。所以当你的Playbok运行报错是没有相应的module时，你只要知道可能出现问题的地方和解决方案就可以。

**1 下载ansible module extra项目**

```
git clone https://github.com/ansible/ansible-modules-extras.git
```

我的一下在/home/jshi/software/目录下了，后面会用到这个目录。

**2 修改配置文件或者环境变量**

**方法1 - 改ansible默认配置文件/etc/ansible/ansible.cfg**

修改ansible配置文件/etc/ansible/ansible.cfg, 添加一行

```
library    = /home/jshi/software/ansible-modules-extras/
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

如果需要在重启后生效，那么放在~/.bashrc中声明ANSIBLE\_LIBRARY变量：

```
$ echo >>~/.bashrc <<EOF

export ANSIBLE_LIBRARY=/project/demo/demoansible/library/ansible-module-extras

EOF

$ source ~/.bashrc

```



