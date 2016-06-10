# 主机的系统变量(facts)

ansible会通过module setup来收集主机的系统信息，这些收集到的系统信息叫做facts，这些facts信息可以直接以变量的形式使用。

哪些facts变量可以引用呢？在命令行上通过调用setup module命令可以查看

```
$ ansible all -m setup -u root
```
怎样在playbook中使用facts变量呢，答案是直接使用：
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



## 使用复杂facts变量



一般在系统中收集到如下的信息，复杂的、多层级的facts变量如何使用呢？


```
...
        "ansible_ens3": {
            "active": true, 
            "device": "ens3", 
            "ipv4": {
                "address": "10.66.192.234", 
                "netmask": "255.255.254.0", 
                "network": "10.66.192.0"
            }, 
            "ipv6": [
                {
                    "address": "2620:52:0:42c0:5054:ff:fef2:e2a3", 
                    "prefix": "64", 
                    "scope": "global"
                }, 
                {
                    "address": "fe80::5054:ff:fef2:e2a3", 
                    "prefix": "64", 
                    "scope": "link"
                }
            ], 
            "macaddress": "52:54:00:f2:e2:a3", 
            "module": "8139cp", 
            "mtu": 1500, 
            "promisc": false, 
            "type": "ether"
        }, 
...
```
那么可以通过下面的两种方式访问复杂的变量中的子属性:

中括号：  
```
{{ ansible_ens3["ipv4"]["address"] }}
```
点号：
```
{{ ansible_ens3.ipv4.address }}
```


## 关闭facts


在Playbook中,如果写gather_facts来控制是否收集远程系统的信息.如果不收集系统信息,那么上面的变量就不能在该playybook中使用了.

```
- hosts: whatever
  gather_facts: no
```