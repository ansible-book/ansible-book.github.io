## file

file module设置远程值机上的文件、软链接（symlinks）和文件夹的权限，也可以用来创建和删除他们。

### 改变文件的权限

当然mode参数可以直接赋值数字权限（必须以0开头），也可以赋值，还可以用来增加和删除权限。具体的写法见下面的代码：

```
- file:
    path: /etc/foo.conf
    owner: foo
    group: foo
    mode: 0644
    #mode: "u=rw,g=r,o=r"
    #mode: "u+rw,g-wx,o-rwx"
```

### 创建文件的软链接

注意这里面的src和sest参数的含义是和copy module不一样的，file module里面所操作的文件都是远程节点上的文件。
```
- file:
    src: /file/to/link/to
    dest: /path/to/symlink
    owner: foo
    group: foo
    state: link
```

### 创建一个新文件

像touch命令一样创建一个新文件

```
- file:
    path: /etc/foo.conf
    state: touch
    mode: "u=rw,g=r,o=r"
```

### 创建新的文件夹

```
# create a directory if it doesn't exist
- file:
    path: /etc/some_directory
    state: directory
    mode: 0755
```
