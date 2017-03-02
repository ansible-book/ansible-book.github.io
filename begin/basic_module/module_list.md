# 介绍几个常用的module

学习Linux操作系统，如果不能一些基本的命令，那么真的没有办法用Linux。所以学习Ansible也非常有必要了解一些常用的module。

接下来介绍一些会在接下来的章节中用到的module，也是很常用的module。

调试和测试类的module
* [ping](module_ping.html) - ping一下你的远程主机，如果可以通过ansible成功连接，那么返回pong
* [debug](module_debug.html) - 用于调试的module，只是简单打印一些消息，有点像linux的echo命令。

文件类的module
* [copy](module_copy.html) - 从本地拷贝文件到远程节点
* [template](module_template.html) - 从本地拷贝文件到远程节点，并进行变量的替换
* [file](module_file.html) - 设置文件的属性

linux上常用的操作
* [user](module_user.html) - 管理用户账户
* [yum](module_yum.html) - red hat系linux上的包管理
* [service](module_service.html) - 管理服务
* [firewalld](module_firewalld.html) - 管理防火墙中的服务和端口

执行Shell命令
* [shell](module_shell.html) - 在节点上执行shell命令，支持$HOME和"<", ">", "|", ";" and "&"
* [command](module_command.html) - 在远程节点上面执行命令，不支持$HOME和"<", ">", "|", ";" and "&"
