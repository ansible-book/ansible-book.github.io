# Role - Playbook的“Package”

Role比include更强大灵活的代码重用和分享机制。Include类似于编程语言中的include，是重用单个文件的，重用的功能有限。

而Role类似于编程语言中的“函数”，可以重用一个完整的功能，例如安装和配置apache，需要
* 安装包
* 提供模版配置文件
* 提供handler来保证配置后重起
* 如果用户没有指定端口，那么就使用默认的端口。

Ansible非常提倡在playbook中使用role，并且提供了一个分享role的平台Ansible Galaxy, https://galaxy.ansible.com/, 在galaxy上可以找到别人写好的role。在后面的章节中，我们再详细介绍如果使用它。
