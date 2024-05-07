#!/bin/bash

source podman.env

podman run -it --rm --name $containerName -p 80:80 $imageName
