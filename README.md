# Source of https://daniel.melzaks.com

## How to setup, if it doesn't have the .gitmodules file setup

```
git clone --recurse-submodules -j8 git@github.com:TeamLinux01/daniel.melzaks.com.git && \
cd daniel.melzaks.com/themes/hugo-profile && \
git checkout master && \
cd ../../public && \
git checkout main
```

## How to edit

* `hugo.yaml`: how to modify the overall website layout
* `content/blogs`: folder that stores the blog entries via `.md` files
* `content/images`: folder that stores images
