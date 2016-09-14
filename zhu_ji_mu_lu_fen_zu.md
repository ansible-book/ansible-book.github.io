# 远程主机的分组

简单的分组\[\]内是组名

```ini
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com

[webservers]
www[01:50].example.com

[databases]
db-[a:f].example.com

```

分组usa的子组还可以是其它的组,例如\[usa:children\]中还可以子组southeast, \[southeast:children\]中还可以包含atlanta和releigh

```
[atlanta]
host1
host2

[raleigh]
host2
host3

[southeast:children]
atlanta
raleigh


[usa:children]
southeast
northeast
southwest
northwest

```

