# 条件选择



## When语句


有时候用户有可能需要某一个主机越过某一个特定的步骤.这个过程就可以简单的像在某一个特定版本的系统上 少装了一个包一样或者像在一个满了的文件系统上执行清理操作一样. 这些操作在Ansible上,若使用`when`语句都异常简单.

```
tasks:
  - name: "shutdown Debian flavored systems"
    command: /sbin/shutdown -t now
    when: ansible_os_family == "Debian"
```

忽略错误

```
tasks:
  - command: /bin/false
    register: result
    ignore_errors: True
  - command: /bin/something
    when: result|failed
  - command: /bin/something_else
    when: result|success
  - command: /bin/still/something_else
    when: result|skipped
```

如何查看远程中的系统变量
```
ansible hostname.example.com -m setup
```

返回值的转换
```
tasks:
  - shell: echo "only on Red Hat 6, derivatives, and later"
    when: ansible_os_family == "RedHat" and ansible_lsb.major_release|int >= 6
```