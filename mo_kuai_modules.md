# 模块Modules

你http://docs.ansible.com/ansible/modules_by_category.html上查阅Module文档资料的时候,你发现每一个Module文档的底部都会表示,这是一个"Core Module",或者这是一个"Extra Module".
比如yum就是一个core module, http://docs.ansible.com/ansible/yum_module.html
yum_repository就是一个extra module, http://docs.ansible.com/ansible/yum_repository_module.html

Core区别和extra module有什么区别呢?
首先Core module是比较常用的module,并且经过严格测试的.
你在使用的时候不用进行格外的配置和安装就可以直接使用的.

extra module是