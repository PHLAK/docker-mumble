#!/usr/bin/env bash
set -o errexit

# Set the image name
IMAGE_NAME="phlak/mumble"

# Set script directory path
SCRIPT_DIR="$(dirname $(readlink -f ${0}))"

# Build the image
docker build --force-rm --pull --tag ${IMAGE_NAME}:local ${SCRIPT_DIR}

# Notify user of success
echo "Sucessfully created image: ${IMAGE_NAME}:local"
