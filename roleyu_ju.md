# Role语句


强大的代码重用机制。重用包括vars_files, tasks, and handlers

Role的目录结构：

<table>
    <tr>
        <td>
            role的目录结构
        </td>
        <td>
            main.yml中的使用
        </td>
    </tr>
    <tr>
        <td>
            <pre>
<code class='lang-yml'>
site.yml
webservers.yml
fooservers.yml
roles/
   common/
     files/
     templates/
     tasks/
     handlers/
     vars/
     defaults/
     meta/
   webservers/
     files/
     templates/
     tasks/
     handlers/
     vars/
     defaults/
     meta/
</code>
</pre>
        </td>
        <td>
            <pre>
<code>
---
- hosts: webservers
  roles:
     - common
     - webservers
</code>
</pre>
        </td>
    </tr>
</table>


