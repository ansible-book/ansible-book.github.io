# Extra module的使用方法


使用Exra module需要进行下下面的配置，就可以在命令行或者是playbook中使用了，配置后extra module使用方法和core module的使用方法是一样的


**1 下载ansible module extra项目**

```
git clone https://github.com/ansible/ansible-modules-extras.git
```
我的一下在/home/jshi/software/目录下了.后面会用到

**2 修改配置文件或者环境变量**

**方法1 - 该ansible配置文件**

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


**方法2 - 该环境变量**
```
export ANSIBLE_LIBRARY=/project/demo/demoansible/library/ansible-module-extras
```


## 通过命令查看module的用法

```
ansible-doc module_name
```
例如, core module可以在如何目录下执行查看yum的用法
```
ansible-doc yum
```


extra module必须在配置了extra module的目录下查看用法(行为当前目录下的playbook是一致的):

```
ansible-doc yum_repository
```




