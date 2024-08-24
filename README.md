# Source of https://daniel.melzaks.com

## How to make your own version

1. Create a repo for your [personal github pages](https://pages.github.com).
1. Fork this repo.
1. Change any references to `daniel.melzaks.com` in the repo.
1. Remove all `.md` files from `content` folder, modify the `hugo.yaml`

### How to test your site

1. Run this command on the desktop/server you are testing on:
	```
	hugo server
	```
1. Access the test site via http://localhost:1313

## How to setup

`git clone` the forked repo.

### How to edit

* `hugo.yaml`: how to modify the overall website layout
* `content/blogs`: folder that stores the blog entries via `.md` files
* `content/images`: folder that stores images

### How to publish

> There are a few github secerts that need to be added for the Github Actions. It expects to upload to Docker Hub.

#### List of secerts in Github repo

* DOCKERHUB_USERNAME
* DOCKERHUB_TOKEN

`DOCKER_USERNAME` is the [Docker Hub](https://hub.docker.com/) username.

`DOCKERHUB_TOKEN` is the [Docker Hub Token](https://docs.docker.com/security/for-developers/access-tokens/#create-an-access-token). It should have a scope of `Read & Write`.
