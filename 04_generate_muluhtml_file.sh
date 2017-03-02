#!/bin/bash

muluFile=_includes/mulu.html
github-markdown SUMMARY.md > $muluFile
sed -i 's/\.md//g' $muluFile
sed -i 's/href="/href="\//g' $muluFile
sed -i '1,3d' $muluFile

muluFile=mulu.md
sed -i 's/\.md//g' $muluFile
sed -i 's/href="/href="\//g' $muluFile
