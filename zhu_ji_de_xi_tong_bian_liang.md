# 主机的系统变量

ansible会通过facts来收集主机的系统信息，这些信息可以直接以变量的形式引用。

哪些facts变量可以引用呢？

```
$ ansible all -m setup -u root
```

```
---
- hosts: all
  user: root
  tasks:
  - name: echo system
    shell: echo {{ ansible_os_family }}
  - name install ntp on Debian linux
    apt: name=git state=installed
    when: ansible_os_family == "Debian"
  - name install ntp on redhat linux
    yum: name=git state=present
    when: ansible_os_family == "RedHat"
```