## firewalld

firewalld module为某服务和端口添加firewalld规则。firewalld中有正在运行的规则，和永久的规则，firewalld module都支持。

firewalld要求远程节点上的firewalld版本在0.2.11以上。

### 为服务添加firewalld规则
```
- firewalld:
    service: https
    permanent: true
    state: enabled
```

```
- firewalld:
    zone: dmz
    service: http
    permanent: true
    state: enabled
```
### 为端口号添加firewalld规则

```
- firewalld:
    port: 8081/tcp
    permanent: true
    state: disabled
```

```
- firewalld:
    port: 161-162/udp
    permanent: true
    state: enabled
```

### 其它复杂的firewalld规则

```
- firewalld:
    rich_rule: 'rule service name="ftp" audit limit value="1/m" accept'
    permanent: true
    state: enabled
```

```
- firewalld:
    source: 192.0.2.0/24
    zone: internal
    state: enabled
```

```
- firewalld:
    zone: trusted
    interface: eth2
    permanent: true
    state: enabled
```

```
- firewalld:
    masquerade: yes
    state: enabled
    permanent: true
    zone: dmz
```
