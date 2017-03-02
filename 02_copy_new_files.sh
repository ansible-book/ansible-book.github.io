#!/bin/bash

SOURCE_FOLDER=/home/jshi/project/learn_ansible/ansible-first-book

declare -a arrayname=(*.md "*.png" "*.jpg" "advance" "architecture" "begin" "reference")

for t in "${arrayname[@]}"
do
ls -l ${SOURCE_FOLDER}/$t
cp -rf ${SOURCE_FOLDER}/$t .
done

cp README.md index.md
cp SUMMARY.md mulu.md
