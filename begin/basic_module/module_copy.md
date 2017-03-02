## copy
从当前的机器上copy静态文件到远程节点上，并且设置合理的文件权限。注意，copy module拷贝文件的时候，会先比较下文件的checksum，如果相同则不会拷贝，返回状态OK；如果不同才会拷贝，返回状态为changed。

### 设置文件权限

利用mode设置权限可以是用数字，当然也可以是符号的形式"u=rw,g=r,o=r"和"u+rw,g-wx,o-rwx"

```
- copy:
    src: /srv/myfiles/foo.conf
    dest: /etc/foo.conf
    owner: foo
    group: foo
    mode: 0644
```

### 备份结点上原来的文件

backup参数为yes的时候，如果发生了拷贝操作，那么会先备份下目标节点山的原文件。当两个文件相同时，不会进行拷贝操作，当然也没有必要备份啦。

```
- copy:
    src: sudoers
    dest: /tmp
    backup: yes
```

### 拷贝后的验证操作

validate参数接需要验证的命令。一般需要验证拷贝后的文件，所以%s可以指代拷贝后的文件。当copy module中加入了validate参数，不仅需要成功拷贝文件，还需要validate命令返回成功的状态，整个module的执行状态才是成功。

```visudo -cf /etc/sudoers```是验证sudoers文件有没有语法错误的命令。

```
- copy:
    src: /mine/sudoers
    dest: /etc/sudoers
    validate: 'visudo -cf %s'
```
