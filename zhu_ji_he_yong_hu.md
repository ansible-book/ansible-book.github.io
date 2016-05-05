# 主机和用户




| key | 含义  |
| -- | -- |
| **hosts** | 为主机的IP，或者主机组名，或者关键字all |
|**user** | 在远程以哪个用户身份执行。 |
| **become** | 切换成其它用户身份执行，值为yes或者no |
| **become_method** | 与became一起用，指可以为‘sudo’/’su’/’pbrun’/’pfexec’/’doas’ |
| **become_user** | 与bacome_user一起用，可以是root或者其它用户名 |

脚本里用became的时候，执行的playbook的时候可以加参数--ask-become-pass

```ansible-playbook deploy.yml --ask-become-pass```
