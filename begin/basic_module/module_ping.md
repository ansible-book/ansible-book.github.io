## ping

这个就最常用的测试一个节点有没有配置好ssh连接的module。不过它可不是简单像linux命令中ping一下远程节点，而是首先检查下能不能SSH登陆，然后再检查下远程节点的python版本漫不满足要求，如果都满足则会返回成功pong。

ping不需要传入任何参数。因为ping是测试节点连接是不是通的，所以一般在命令行中使用的时候比在playbook的脚本中多，下面是ping在命令行中的用法：

```
ansible servers -m ping
```
