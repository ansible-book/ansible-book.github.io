# Ansible用命令管理主机

Ansbile Ad-Hoc Commands

```$ansible all -m ping -u bruce```

```$ansible all -a "/bin/echo hello"```

```$ansible atlanta -a "/sbin/reboot" -f 10```

```$ ansible atlanta -m copy -a "src=/etc/hosts dest=/tmp/hosts"```

```$ ansible webservers -m yum -a "name=acme state=present"```

```$ ansible all -m user -a "name=foo password=<crypted password here>"```

```$ ansible webservers -m git -a "repo=git://foo.example.org/repo.git dest=/srv/myapp version=HEAD"```

```$ ansible webservers -m service -a "name=httpd state=started"```

```$ ansible all -m setup```
