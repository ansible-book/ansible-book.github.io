---
 layout: home
 title: 利用tags执行部分tasks
---

# 利用tags执行部分tasks

如果playbook文件比较大，在执行的时候只是想执行部分功能，这个时候没有有解决方案呢？Playbook提供了tags便签可以实现部分运行。

## tags的基本用法

例如，文件example.yml如何所示，标记了两个tag：packages和configuration

```
tasks:

  - yum: name=\{\{ item \}\} state=installed
    with_items:
       - httpd
    tags:
       - packages

  - name: copy httpd.conf
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
    tags:
       - configuration

  - name: copy index.html
    template: src=templates/index.html.j2 dest=/var/www/html/index.html
    tags:
       - configuration
```

* 那么我们在执行的时候，如果不加任何tag参数，那么会执行所有的tasks

```
  ansible-playbook example.yml
```

* 指定执行安装部分的tasks，则可以利用关键字tags

```
  ansible-playbook example.yml --tags "packages"
```

* 指定不执行packages部分的task，则可以利用关键字skip-tags

```
  ansible-playbook example.yml --skip-tags "configuration"
```

## 特殊的Tags

* “always”

  tags的名字是用户自定义的，但是如果你把tags的名字定义为“always”，那么就有点特别了。只要在执行playbook时，没有明确指定不执行always tag，那么它就会被执行。

  在下面的例子中，即使你只指定执行packages，那么always也会被执行。

```
  tasks:

    - debug: msg="Always print this debug message"
      tags:
        - always

    - yum: name=\{\{ item \}\} state=installed
      with_items:
         - httpd
      tags:
         - packages

    - template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
      tags:
         - configuration

```

  指定运行packages时，还是会执行always tag对应的tasks

```
  ansible-playbook tags_always.yml --tags "packages"
```

* “tagged”，“untagged”和“all”

```
  tasks:

    - debug: msg="I am not tagged"
      tags:
        - tag1

    - debug: msg="I am not tagged"

```

  分别指定--tags为“tagged”，“untagged”和“all”试下效果吧：

```
  ansible-playbook tags_tagged_untagged_all.yml --tags tagged
```

```
  ansible-playbook tags_tagged_untagged_all.yml --tags untagged
```

```
  ansible-playbook tags_tagged_untagged_all.yml --tags all
```

## 在include中和role中使用tags

include语句指定执行的tags的语法：

```
- include: foo.yml
  tags: [web,foo]

```

调用role中的tags的语法为：

```
roles:
  - { role: webserver, port: 5000, tags: [ 'web', 'foo' ] }

```



