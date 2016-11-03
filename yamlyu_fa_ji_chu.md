---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home
---
# YAML语法基础


## 文件开始符 

```
---
```

## 数组List

```.yaml
- element1
- element2
- element3
```



数组中的每个元素都是以 \- 开始的。


## 字典(Hash or Directory)


```
key: value
```


key和value已冒号加空格分隔。



## 复杂的字典

字典的嵌套
```
# An employee record
martin:
    name: Martin D'vloper
    job: Developer
    skill: Elite
```

字典和数组的嵌套

```yaml
-  martin:
    name: Martin D'vloper
    job: Developer
    skills:
      - python
      - perl
      - pascal
-  tabitha:
    name: Tabitha Bitumen
    job: Developer
    skills:
      - lisp
      - fortran
      - erlang
```


## 注意的地方


变量里有：要加引号

```
foo: "somebody said I should put a colon here: so I did"
```

变量的引用要加引号
```
foo: "{{ variable }}" 
```

## 参考资料



https://en.wikipedia.org/wiki/YAML

http://www.yamllint.com/