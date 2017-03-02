## service

管理远程节点上的服务，什么是服务呢，比如httpd、sshd、nfs、crond等。


### 开、关、重起、重载服务

* 开httpd服务

  ```
  - service:
      name: httpd
      state: started
  ```

* 关服务

  ```
  - service:
      name: httpd
      state: stopped
  ```

* 重起服务

  ```
  - service:
      name: httpd
      state: restarted
  ```

* 重载服务

  ```
  - service:
      name: httpd
      state: reloaded
  ```

### 设置开机启动的服务

```
- service:
    name: httpd
    enabled: yes
```

### 启动网络服务下的接口

```
- service:
    name: network
    state: restarted
    args: eth0
```
