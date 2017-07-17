#!/bin/bash

muluFile=_includes/mulu.html
github-markdown SUMMARY.md > $muluFile
sed -i 's/\.md//g' $muluFile
sed -i 's/href="/href="\//g' $muluFile
sed -i '1,3d' $muluFile
sed -i 's/href="\(.*\)"/ \{% if page.url == "\1.html" %\} class="active"\{% endif %\} href="\1"/' _includes/mulu.html

muluFile=mulu.md
sed -i 's/\.md//g' $muluFile
sed -i 's/href="/href="\//g' $muluFile
