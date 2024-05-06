#!/bin/bash

hugo --gc --minify
./podman_build.sh
./podman_push.sh
