#!/bin/bash

containerImage="docker.io/teamlinux01/daniel.melzaks.com:latest"

buildah bud -t $containerImage .
