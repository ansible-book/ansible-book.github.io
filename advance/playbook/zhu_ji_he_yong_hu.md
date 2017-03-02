---
 layout: home
 title: 主机和用户(hostsuser)
---

# 主机和用户(hostsuser)
# 主机和用户

| key | 含义 |
| --- | --- |
| **hosts** | 为主机的IP，或者主机组名，或者关键字all |
| **user** | 在远程以哪个用户身份执行。 |
| **become** | 切换成其它用户身份执行，值为yes或者no |
| **become\_method** | 与became一起用，指可以为‘sudo’/’su’/’pbrun’/’pfexec’/’doas’ |
| **become\_user** | 与bacome\_user一起用，可以是root或者其它用户名 |

脚本里用became的时候，执行的playbook的时候可以加参数--ask-become-pass，则会在执行后提示输入sudo密码。

`ansible-playbook deploy.yml --ask-become-pass`

