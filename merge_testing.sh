#!/bin/bash

git merge --no-ff --no-commit testing
git reset HEAD podman.env
git checkout -- podman.env
git commit -m "merged testing"
