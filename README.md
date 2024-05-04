# Source of https://daniel.melzaks.com

## How to setup

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

### How to publish

1. In the root of the repo. run `hugo --gc --minify`.
1. Change directory to `public`.
1. Stage any changed files and commit.
1. Push to all remote repositories.

```
hugo --gc --minify && \
cd public && \
git add . && \
git commit -m "Updated website" && \
git push
```
