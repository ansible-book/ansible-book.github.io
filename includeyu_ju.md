# Include语句


<div style="width: 60%;">

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
<div style="width: 40%">
<pre>
<code>
---
tasks:

  - include: tasks/foo.yml
</code>
</pre>
</div>