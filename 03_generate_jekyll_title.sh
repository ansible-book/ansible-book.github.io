#!/bin/bash

lineRegex='\[(.*)\]\((.*)\)'
cat  SUMMARY.md | while read line
do
	# echo "$t"
	if [[ $line =~ $lineRegex ]]
	then
		echo "--------------"
	  mdFileName=${BASH_REMATCH[2]}
		mdTitle=${BASH_REMATCH[1]}
		echo "${mdFileName}:${mdTitle}"
		echo "--------------"
		sed -i '1,/^$/{/^$/d}' $mdFileName
		sed -i '1,/^\r$/{/^\r$/d}' $mdFileName
		sed -ie '1s/^/---\n layout: home\n title: '"${mdTitle}"'\n---\n\n# '"${mdTitle}"'\n/' $mdFileName
		# #replace the title with the same name
		# sed -i '
		# /'"# ${mdTitle}"'/ {
		# 								N
		# 								/\n'"# ${mdTitle}"'/ {
		# 																s/'"# ${mdTitle}\n# ${mdTitle}"'/'"# ${mdTitle}"'/g
		# 								}
		# }' $mdFileName

		#replace the title with the same/diff name

		sed -i '
		/'"# ${mdTitle}"'/ {
										N
										/\n.*$/ {
																		s/'"# ${mdTitle}\n"'.*/'"# ${mdTitle}"'/g
										}
		}' $mdFileName


		# replace the content
		sed -ie 's/^ *```/```/g' $mdFileName
		# sed -ie 's/```.*$/```/g' $mdFileName
		sed -i '
		/./ {
		        N
		        /\n```/ {
		                s/\n```/\n\n```/g
		        }
		}' $mdFileName

		sed -i 's/{{/\\{\\{/g' $mdFileName
		sed -i 's/\}\}/\\\}\\\}/g' $mdFileName
	else
		echo "does NOT match"
	fi
done

sed -i '1s/^/---\n layout: home\n title: Ansible入门\n---\n/' index.md
sed -i '1s/^/---\n layout: home\n title: 目录\n---\n/' mulu.md
