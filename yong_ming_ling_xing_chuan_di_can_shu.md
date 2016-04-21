# 用命令行传递参数


在release.yml文件里，变量hosts和user需要从命令行传递。

```
---

- hosts: '{{ hosts }}'
  remote_user: '{{ user }}'

  tasks:
     - ...

```

在命令行里面

```
ansible-playbook release.yml --extra-vars "hosts=vipers user=starbuck"
```
还可以用json格式传递参数
```
ansible-playbook clean.yml --extra-vars "{'hosts':'vm-rhel7-1', 'user':'root'}"
```
还可以将参数放在文件里面
```
ansible-playbook clean.yml --extra-vars "@test.json"
```