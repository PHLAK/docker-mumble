#!/usr/bin/env bash
set -o errexit

# Set the image name
IMAGE_NAME="phlak/mumble"

# Set script directory path
SCRIPT_DIR="$(dirname $(readlink -f ${0}))"

# Set image tag
TAG="$(grep 'ENV MUMBLE_VERSION' Dockerfile | awk '{print $3}')"

# Build the image
docker build --force-rm --pull --tag ${IMAGE_NAME}:${TAG} ${SCRIPT_DIR}

# Notify user of success
echo "Sucessfully created image: ${IMAGE_NAME}:${TAG}"
