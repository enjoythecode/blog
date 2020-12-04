import os
import time
import html as htmllib

posts = []
src_path = "src"

for (dirpath, dirnames, filenames) in os.walk(src_path):
    posts.extend([f for f in filenames if ".m" in f and not "index.md" in f])

info = []
for post in posts:
    with open(os.path.join(src_path, post)) as postfile:
        heading = postfile.readline()[1:].replace("\n", " ").strip(" ")
        text = ""
        for l in postfile.readlines():
            text += l.replace("\n", " ")
        excerpt = text[:140] + "..."

        info.append({
            "file": post,
            "path": os.path.join(src_path, post),
            "heading": heading,
            "excerpt": excerpt
        })

html = "<h1>All Posts</h1>"

for post in info:
    html += "<div class='post-list-post'>\n"
    html += "<b><a href='" + post["file"].replace(".md",".html") + "'>" + post["heading"] + "</a></b>\n"
    html += "<p class='excerpt'>" + post["excerpt"] + "</p>\n"
    html += "</div>\n\n"

print(html)