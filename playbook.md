# Playbo# Playbook


## YML


ansible的脚本语言,yaml格式. 请参考[YAML语法结构章节](yamlyu_fa_ji_chu.html)


## TASK的状态


tasks是有状态(status)的!!!
TASK


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