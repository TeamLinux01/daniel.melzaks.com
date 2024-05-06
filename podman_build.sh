#!/bin/bash

source podman.env

buildah bud -t $containerImage .
