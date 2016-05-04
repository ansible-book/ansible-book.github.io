# Playbo# Playbook


## YML


ansible的脚本语言,yaml格式. 请参考[YAML语法结构章节](yamlyu_fa_ji_chu.html)


## TASK的状态


每一个task会调用一个module,在module中会去检查当前系统状态是否需要执行当前module的动作.

如果执行那么task会得到返回值changed;
如果不需要执行,那么tasks得到返回值ok

copy module的判断方法如下,比较文件的checksum
https://github.com/ansible/ansible-modules-core/blob/devel/files/copy.py


### 例子


以一个copy文件的task为例子:
```
  tasks:
  - name: Copy the /etc/hosts
    copy: src=/etc/hosts dest=/etc/hosts
```

第一次执行,它的结果是这个样子的:

TASK的状态是changed
![](copy_hosts_1st.png)


第二次执行是下面这个样子的:

TASK的状态是ok,由于第一次执行copy_hosts.yml的时候,已经拷贝过文件,那么ansible目标文件的状态避免重复执行.
![](copy_hosts_2nd.png)

下面我更改vm-rhel7-1的/etc/hosts, 再次执行看看:

![](copy_hosts_3rd.png)