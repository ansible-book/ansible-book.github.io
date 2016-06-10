# 指定连接的参数


## 参数


指定Server的连接参数，其中包括连接方法，用户等。
```ini
[targets]

localhost              ansible_connection=local
other1.example.com     ansible_connection=ssh        ansible_user=mpdehaan
other2.example.com     ansible_connection=ssh        ansible_user=mdehaan


[atlanta]
host1 http_port=80 maxRequestsPerChild=808
host2 http_port=303 maxRequestsPerChild=909
```
所有可以指定的参数在文档中
http://docs.ansible.com/ansible/intro_inventory.html#list-of-behavioral-inventory-parameters



## 变量


为一个组指定变量

```
[atlanta]
host1
host2

[atlanta:vars]
ntp_server=ntp.atlanta.example.com
proxy=proxy.atlanta.example.com
```


