# Loop循环



## 标准循环


为了保持简洁,重复的任务可以用以下简写的方式:
```
- name: add several users
  user: name={{ item }} state=present groups=wheel
  with_items:
     - testuser1
     - testuser2
```
如果你在变量文件中或者 ‘vars’ 区域定义了一组YAML列表,你也可以这样做:

with_items: "{{somelist}}"
以上写法与下面是完全等同的:
```
- name: add user testuser1
  user: name=testuser1 state=present groups=wheel
- name: add user testuser2
  user: name=testuser2 state=present groups=wheel
 ```
yum和apt模块中使用with_items执行时会有较少的包管理事务.

请note使用 ‘with_items’ 用于迭代的条目类型不仅仅支持简单的字符串列表.如果你有一个哈希列表,那么你可以用以下方式来引用子项:

```- name: add several users
  user: name={{ item.name }} state=present groups={{ item.groups }}
  with_items:
    - { name: 'testuser1', groups: 'wheel' }
    - { name: 'testuser2', groups: 'root' }```
请note如果同时使用 when 和 with_items （或其它循环声明）,`when`声明会为每个条目单独执行.请参见 the_when_statement 示例.


## 嵌套循环


循环也可以嵌套:

- name: give users access to multiple databases
  mysql_user: name={{ item[0] }} priv={{ item[1] }}.*:ALL append_privs=yes password=foo
  with_nested:
    - [ 'alice', 'bob' ]
    - [ 'clientdb', 'employeedb', 'providerd
