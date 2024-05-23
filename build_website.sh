#!/bin/bash

# builds the image
./podman_build.sh
# pushes the image to container registry
./podman_push.sh
