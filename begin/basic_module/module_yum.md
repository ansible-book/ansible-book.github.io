## yum

yum module是用来管理red hat系的Linux上的安装包的，包括RHEL，CentOS，和fedora 21一下的版本。fedora从版本22开始就使用dnf，推荐使用dnf module来进行安装包的操作。

### 从yum源上安装和删除包

* 安装最新版本的包，如果已经安装了老版本，那么会更新到最新的版本：
  ```
  - name: install the latest version of Apache
    yum:
      name: httpd
      state: latest
  ```

* 安装指定版本的包

  ```
  - name: install one specific version of Apache
    yum:
      name: httpd-2.2.29-1.4.amzn1
      state: present
  ```

* 删除httpd包

  ```
  - name: remove the Apache package
    yum:
      name: httpd
      state: absent
  ```

* 从指定的repo testing中安装包

  ```
  - name: install the latest version of Apache from the testing repo
    yum:
      name: httpd
      enablerepo: testing
      state: present
  ```

### 从yum源上安装一组包

```
- name: install the 'Development tools' package group
  yum:
    name: "@Development tools"
    state: present

- name: install the 'Gnome desktop' environment group
  yum:
    name: "@^gnome-desktop-environment"
    state: present
```

### 从本地文件中安装包

```
- name: install nginx rpm from a local file
  yum:
    name: /usr/local/src/nginx-release-centos-6-0.el6.ngx.noarch.rpm
    state: present
```

### 从URL中安装包

```
- name: install the nginx rpm from a remote repo
  yum:
    name: http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
    state: present
```
