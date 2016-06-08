# Modules的分类



你[Ansible Module文档](http://docs.ansible.com/ansible/modules_by_category.html)上查看单个Module的时候,每一个Module文档的底部都会标识, 这是一个"Core Module", 或者这是一个"Extra Module".

比如, [yum](http://docs.ansible.com/ansible/yum_module.html)就是一个core module, [yum_repository](http://docs.ansible.com/ansible/yum_repository_module.html)就是一个extra module, 


## Core Module



* 比较常用的module
* 经过严格测试的.
* 你在使用的时候不用进行格外的配置和安装就可以直接使用的.



## Extra module

* 次常用的
* 还有可能存在bug的
* 使用的时候需要进行格外的配置和安装