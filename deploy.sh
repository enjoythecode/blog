main (){
	# delete lines after the given pattern in index.md
	# the pattern is where I place my list of posts
	# -i means sed will edit the file in-place!
	sed '1,/SINAN_CUSTOM_INSERT_LIST_OF_POSTS/!d' src/index.md > src/index.md.tmp

	while read -r line; do
		if [ "$line" != "index" ]; then
			printf "\n\n- [$line]($line.html)" >> src/index.md.tmp
		fi
	done < <(list_src_files)

	cat src/index.md.tmp > src/index.md
	rm src/index.md.tmp

    list_src_files | md_to_html
}

list_src_files() {
	find src -name "*.md" | sed -e 's/src\/\(.*\).md/\1/'
}

md_to_html() {
    while read -r f
        do
        pandoc --standalone --template template.html "src/$f.md" > "dst/$f.html"
    done
}

main "$@"
