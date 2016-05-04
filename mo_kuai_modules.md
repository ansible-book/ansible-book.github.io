# 模块Modules

你[Ansible Module文档](http://docs.ansible.com/ansible/modules_by_category.html)上查看单个Module的时候,每一个Module文档的底部都会标识, 这是一个"Core Module", 或者这是一个"Extra Module".

比如, [yum](http://docs.ansible.com/ansible/yum_module.html)就是一个core module, [yum_repository](http://docs.ansible.com/ansible/yum_repository_module.html)就是一个extra module, 


## Core Module



* 比较常用的module
* 经过严格测试的.
* 你在使用的时候不用进行格外的配置和安装就可以直接使用的.



## Extra module

* 次常用的
* 经过测试,不过还有可能存在bug的
* 使用的时候需要进行格外的配置和安装


### Extra module的配置方法


1 下载ansible module extra项目

```
git clone https://github.com/ansible/ansible-modules-extras.git
```
我的一下在/home/jshi/software/目录下了.后面会用到

2 修改配置文件或者环境变量

方法1 - 该ansible配置文件

修改ansible配置文件/etc/ansible/ansible.cfg, 添加一行
```
library	= /home/jshi/software/ansible-modules-extras/
```



ansible-playbook当前的目录下的ansible.cfg,那么只对当前目录的playbook生效.
```
library/ansible-modules-extras
ansible.cfg
use_extra_module.yml
subfolder/use_extra_module_will_throw_error.yml
```

在当前目录的ansible.cfg中,可以使用相对路径
```
library = library/ansible-modules-extras/
```


方法2 - 该环境变量
```
export ANSIBLE_LIBRARY=/project/demo/demoansible/library/ansible-module-extras
```






