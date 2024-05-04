# Source of https://daniel.melzaks.com

## How to setup, if it doesn't have the .gitmodules file setup

```
git clone git@github.com:TeamLinux01/daniel.melzaks.com.git && \
cd daniel.melzaks.com && \
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke && \
git submodule add git@github.com:TeamLinux01/TeamLinux01.github.io.git public
```

## How to edit

* `hugo.yaml`: how to modify the overall website layout
* `content/blogs`: folder that stores the blog entries via `.md` files
* `content/images`: folder that stores images
