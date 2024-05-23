#!/bin/bash

# include the environment variables for $imageName in podman.env
source podman.env

# clean out public folder for static site
rm -vr public
# build the new version of the site
hugo --gc --minify
# build the container image with the site
buildah bud -t $imageName .
