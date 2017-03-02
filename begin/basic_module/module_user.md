## user

user module可以增、删、改Linux远程节点的用户账户，并为其设置账户的属性。


### 增加账户

增加账户johnd，并且设置uid为1040，设置用户的primary group为admin

```
- user:
    name: johnd
    comment: "John Doe"
    uid: 1040
    group: admin
```

创建账户james，并为james用户额外添加两个group

```
- user:
    name: james
    shell: /bin/bash
    groups: admins,developers
    append: yes
```

### 删除账户

删除账户johnd

```
- user:
    name: johnd
    state: absent
    remove: yes
```

### 修改账户的属性

为账户jsmith撞见一个 2048-bit的SSH key，放在~jsmith/.ssh/id_rsa

```
- user:
    name: jsmith
    generate_ssh_key: yes
    ssh_key_bits: 2048
    ssh_key_file: .ssh/id_rsa
```

为用户添加过期时间：

```
- user:
    name: james18
    shell: /bin/zsh
    groups: developers
    expires: 1422403387
```
