# Source of https://daniel.melzaks.com

## How to make your own version

1. Create a repo for your [personal github pages](https://pages.github.com).
1. Fork this repo.
1. Change any references to `daniel.melzaks.com` in the readme, `podman.env` and anywhere else.
1. Remove all `.md` files from `content` folder, modify the `hugo.yaml`

### How to test your site

1. Run this command on the desktop/server you are testing on:
	```
	hugo server
	```
1. Access the test site via http://localhost:1313

## How to setup

```
git clone --recurse-submodules -j8 git@github.com:TeamLinux01/daniel.melzaks.com.git
```

### How to edit

* `hugo.yaml`: how to modify the overall website layout
* `content/blogs`: folder that stores the blog entries via `.md` files
* `content/images`: folder that stores images

### How to publish

> Make sure to edit the `podman.env` file for your container registry, username and image name before running the script.

1. Run the `build_website.sh` script.
1. Pull the image from the container registry on your server.
1. Run the container image and use a reverse proxy container to add TLS.