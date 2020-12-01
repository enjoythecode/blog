# My Blog
Hi there, you've stumbled upon my blog. You can visit it at [blog.enjoythecode.com](https://blog.enjoythecode.com). I share some thoughts for people who enjoy reading what I write.

# Tech
Static site generator by [Roman Zolotarev](blog.enjoythecode.com). I've only modified it a tiny bit to generate a rudimentary list of posts.

# Tasks
I intend to keep this as simple as possible. Here are a few things that I want to add when I have the time:
- Simple minimalistic styling with CSS
- List of latest posts in index.html
- RSS feed

# Development
## Requirements
The two scripts under `bin/`:

```chmod +x bin/ssg5 bin/Markdown.pl```

## Generate Static Files

```bin/ssg5 src dst 'Sinan' 'https://blog.enjoythecode.com/'```

That's it, all the files should be under `dst/`, ready to serve. I use Netlify because it is simple.

