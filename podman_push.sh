#!/bin/bash

# include the environment variables for $imageName in podman.env
source podman.env

# push the container image of the site to Container Registry
podman push $imageName
