#!/bin/bash

# include the environment variables for $containerName and $imageName in podman.env
source podman.env

# run a local container of built image of site, accessible from http://localhost
podman run -it --rm --name $containerName -p 80:80 $imageName
