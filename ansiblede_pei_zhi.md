# ansible的配置



ansible会按照下面的顺序查找配置文件，并使用第一个发现的配置文件。

```
* ANSIBLE_CONFIG (an environment variable)
* ansible.cfg (in the current directory)
* .ansible.cfg (in the home directory)
* /etc/ansible/ansible.cfg
```

Ansible1.5以前的版本顺序为：
```
* ansible.cfg (in the current directory)
* ANSIBLE_CONFIG (an environment variable)
* .ansible.cfg (in the home directory)
* /etc/ansible/ansible.cfg
```

可以配置什麼?

例子:

https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg


列表:

http://docs.ansible.com/ansible/intro_configuration.html#explanation-of-values-by-section
