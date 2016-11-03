---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home
---
# 变量

## 定义

使用YAML格式定义

```
foo:
  field1: one
  field2: two
```

## 使用变量

使用Python的template语言[Jinja2](http://jinja.pocoo.org/docs/dev/templates/#builtin-filters)的语法引用：利用中括号和点号来访问子属性

```
foo['field1']
foo.field1
```

