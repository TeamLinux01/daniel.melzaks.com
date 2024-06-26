#!/bin/bash

# run this when on the main branch, it merges testing without overwriting podman.env
git merge --no-ff --no-commit testing
git reset HEAD podman.env
git checkout -- podman.env
git commit -m "merged testing"
