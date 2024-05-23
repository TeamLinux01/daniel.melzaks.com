#!/bin/bash

source podman.env

hugo --gc --minify
buildah bud -t $imageName .
