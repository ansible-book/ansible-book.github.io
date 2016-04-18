# Include语句

像其它语言的Include语句一样，可以这样用：
<div class="component-grid">
<div class="grid-entry" style="top:0%; left:0.00%; height:100%; width:50.00%;">

<pre>
<code>
---
# possibly saved as tasks/foo.yml

- name: placeholder foo
  command: /bin/foo

- name: placeholder bar
  command: /bin/bar
</code>
</pre>
</div>

<div class="grid-entry" style="top:0%; left:60.00%; height:100%; width:40.00%;">
<pre>
<code>
---
tasks:

  - include: tasks/foo.yml
</code>
</pre>
</div>
</div>