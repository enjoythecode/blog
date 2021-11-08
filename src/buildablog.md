# Let's Build a Static Blog Generator (SBG)

There are so many static blog generators out there, each with their own dependencies, and advertising different features.

After being frustrated with trying to set up some of these tools, I decided I wanted to build my own solution using simple shell scripting. I'll document my steps along the way, so that you can retrace my steps and intuitively understand how the thing works.

## What Will The SBG do?
My use case is super simple; there should be a command that takes in a source and a destination directory. It should compile all Markdown (`.md`) files in that source directory, wrap them in some basic style and put statically generated HTML files under the destination directory.

As an extension, I'll also have the tool generate a landing page with a list of all the blog posts.

## Requirements
`pandoc`

## Credits
[This blog post has been the primary source for the work described below.](https://www.arthurkoziel.com/convert-md-to-html-pandoc/) 

## First Steps with Pandoc
Pandoc infers input file format from the extension, and by default converts to HTML, so our initial command will be very simple. We can invoke pandoc on the source markdown of this like so;

`pandoc buildablog.md` (that's meta!)

And just like that, we have some HTML printed on to the terminal. However, it is partial HTML, it doesn't include boilerplate like `<head>` to make browsers happy. We can fix this with a single flag to pandoc, like so;

`pandoc --standalone buildablog.md`

Yay, we are no longer making web browsers unhappy. However, we are currently looking at raw HTML in the terminal. Let's store the output of pandoc in a file so that we can open it in a browser. This is indeed valid HTML that gets rendered with links, headers, and `code` blocks!

`pandoc --standalone buildablog.md > buildablog.html`

Now that we have some way of converting markdown files to HTML, I will first focus on making our blog presentable, and then scaling it so that it can power blogs with more than one post.

## Making our Blog Pretty
I have some CSS that I'd like applied to every single page. How do we achieve this with `pandoc`? We will use a custom template which will include the styling that we want.

For starters, our template will be the simple HTML scaffolding with CSS added in, like so;

```
<html>
    <head>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Castoro:ital@0;1&display=swap" rel="stylesheet"> 
        <style>
            body {
                font-family: 'Castoro', serif;
                font-size: large;
                background-color: #222;
                color: #e6e6e6;
                border-color: #e6e6e6;
            }
            a {color: #eee;}
            a:visited {color: #bbb;}
            #content{max-width: 600px;padding: 5%;}
        </style>
    </head>
    <body>
        <div id="content">
            $body$
        </div>
    </body>
</html>
```

Notice the little pandoc variable `$body$`; that is where pandoc will look to inject the markup generated from markdown. After saving the above template to `template.html`, we can like so:

`pandoc --standalone --template template.html buildablog.md > buildablog.html`

Yay, the white background no longer burns our eyes, and we also have a nice, non-default font! Next up, I'll wrap this powerful one-liner in a script that will apply it to all `.md` files in a given folder.

A quick tangent: this template file will provide us with flexibility as we can put placeholders for other variables in the template, and define those on a post-by-post basis by defining those variables in the frontmatter of our markdown source files.

## Going Beyond Single Files

So, we are able to make individual `.md` files into blog pages. How do we extend this so that all posts in a given directory are converted to HTML pages in another directory?

First, let's find all `.md` files under `src/` using `find`:

`find src -name "*.md"`

This will give us the whole path including `src`, however, we want just the filename without the extension so that we can easily adapt our existing pandoc comment. I use `sed` to grab the part we are interested in;

`find src -name "*.md" | sed -e 's/src\/\(.*\).md/\1/`

Last thing will be to pipe all these into the `pandoc` command above. I will now graduate up to an `.sh` file to keep the code manageable, while still keeping the amount of code minimal.

```
main (){
    find src -name "*.md" | sed -e 's/src\/\(.*\).md/\1/' | md_to_html
}

md_to_html() {
    while read -r f
        do
        pandoc --standalone --template src/template.html "src/$f.md" > "dst/$f.html"
    done
}

main "$@"
```

Saving this to a file (I used `deploy.sh`), and running it in the command line "compiles" all our blog posts from Markdown to HTML, just like we wanted! 
