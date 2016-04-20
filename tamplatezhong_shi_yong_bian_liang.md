# tamplate中使用变量

```
---
- hosts: server
  user: root
  vars:
    port: 80
    root_dir: /usr/share/nginx/html
  tasks:
    - name: write our nginx.conf
      template: src=nginx.conf.j2 dest=/etc/nginx/nginx.conf
      notify: restart nginx

    - name: write our /etc/nginx/sites-available/default
      template: src=default-site.j2 dest=/etc/nginx/sites-available/default
      notify: restart nginx

    - name: deploy website content
      template: src=index.html.j2 dest=/usr/share/nginx/html/index.html
```

在template中可以直接使用系统变量和用户自定义的变量
```
# {{ ansible_managed }}

server {
	
	listen {{ port }};
	server_name {{ ansible_hostname }};
	root {{ root_dir }};
	index index.html index.htm;

	location / {
		try_files $uri $uri/ =404;
	}

	error_page 404 /404.html;
	error_page 500 502 503 504 /50x.html;
	location = /50x.html {
		root {{ root_dir }};
	}

}

```