main (){
    find src -name "*.md" | sed -e 's/src\/\(.*\).md/\1/' | md_to_html
}

md_to_html() {
    while read -r f
        do
        pandoc --standalone --template template.html "src/$f.md" > "dst/$f.html"
    done
}

main "$@"