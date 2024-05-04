# Source of https://daniel.melzaks.com

## How to make your own version

1. Create a repo for your [personal github pages](https://pages.github.com).
1. Fork this repo.
1. Change the `.gitmodules` to point public at your github pages repo.
1. Remove all `.md` files from `content` folder, modify the `hugo.yaml`

### How to test your site

1. Run this command on the desktop you are testing on:
	```
	hugo server
	```
1. Access the test site via http://localhost:1313

## How to setup

```
git clone --recurse-submodules -j8 git@github.com:TeamLinux01/daniel.melzaks.com.git && \
cd daniel.melzaks.com/themes/hugo-profile && \
git checkout master && \
cd ../../public && \
git checkout main
```

### How to edit

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
