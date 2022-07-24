# Sinan's Blog
Hi there, you've stumbled upon my blog. You can visit it at [blog.enjoythecode.com](https://blog.enjoythecode.com). I share some thoughts for people who enjoy reading what I write.

# Tech
Static blog generator converts written by me. I used to use a similar script by Roman Zolotarev, but I figured it'd be fun to [write mine, so I did](https://blog.enjoythecode.com/buildablog.html)

The static files are hosted by Netlify for free.

# Tasks
I intend to keep this as simple as possible. Here are a few things that I want to add when I have the time:
- List of latest posts in index.html
- sitemap.xml
- Fix: `code` blocks are weirdly indented in HTML.

# Building the Site
## Dependencies
`pandoc`

## Generate Static Files
Run `./deploy.sh`

That's it, all the HTML should be under `dst/`, ready to serve.
