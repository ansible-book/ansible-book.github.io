## debug

打印输出信息，和linux上的echo命令很像

### 通过参数msg定义打印的字符串

msg中可以嵌入变量,下面的例子中注入了系统变量，ansible在执行playbook之前会收集一些比较常用的系统变量，你在playbook中不需要定义直接就可以使用。

```
- debug:
    msg: "System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}"
```

执行结果

```
TASK [debug] *******************************************************************
ok: [localhost] => {
    "msg": "System localhost has gateway 192.168.50.1"
}
```

### 通过参数var定义需要打印的变量

变量可以是系统变量，也可以是动态的执行结果，通过关键字regester注入到变量中。

* 打印系统的变量

  ```
  - name: Display all variables/facts known for a host
    debug:
      var: hostvars[inventory_hostname]["ansible_default_ipv4"]["gateway"]
  ```
  执行结果：
  ```
  TASK [Display part of variables/facts known for a host] ************************
  ok: [localhost] => {
      "hostvars[inventory_hostname][\"ansible_default_ipv4\"][\"gateway\"]": "192.168.50.1"
  }
  ```
* 打印动态注入的变量

  ```
  - shell: /usr/bin/uptime
    register: result

  - debug:
      var: result
  ```
  执行结果

  ```
  TASK [command] *****************************************************************
  changed: [localhost]

  TASK [debug] *******************************************************************
  ok: [localhost] => {
      "result": {
          "changed": true,

          "cmd": "/usr/bin/uptime",
          "delta": "0:00:00.003212",
          "end": "2017-01-01 21:30:02.817443",
          "rc": 0,
          "start": "2017-01-01 21:30:02.814231",
          "stderr": "",
          "stdout": " 21:30:02 up 12:38,  8 users,  load average: 1.13, 1.31, 1.14",
          "stdout_lines": [
              " 21:30:02 up 12:38,  8 users,  load average: 1.13, 1.31, 1.14"
          ],
          "warnings": []
      }
  }
  ```
