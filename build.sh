#!/bin/bash

VERSION=latest
IMAGE=vwn/docker-git-filter-repo

# Build latest
docker build -t ${IMAGE}:${VERSION} --compress --no-cache --platform linux/amd64 . || exit 1

# # Get current docker-git-filter-repo version number
build_version=$(docker run --rm ${IMAGE}:${VERSION} /usr/local/bin/git-filter-repo --version || exit 1)

if [ -z "${build_version}" ]; then
    echo "Failed when trying to get git-filter-repo version from latest container :("
    exit 1
fi

# If the build was successful, then we can tag with current version
docker tag ${IMAGE}:${VERSION} ${IMAGE}:"${build_version}"
