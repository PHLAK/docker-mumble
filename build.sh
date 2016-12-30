#!/usr/bin/env bash
set -o errexit

## PRE-RUN SETUP & CONFIGURATION
########################################

SCRIPT_DIR="$(dirname $(readlink -f ${0}))"

IMAGE_NAME="phlak/mumble"
TAG="$(grep 'ARG MUMBLE_VERSION' Dockerfile | awk -F = '{print $2}')"

## SCRIPT USAGE
########################################

function usageShort() {
    echo "Usage: $(basename ${0}) [OPTIONS]"
}

function usageLong() {

    usageShort

	cat <<-EOF

	    OPTIONS:

	        -h, --help     Print this help dialogue
	        -p, --purge    Purge the image after build

	EOF

}

## OPTION / PARAMATER PARSING
########################################

PARSED_OPTIONS=$(getopt -n "${0}" -o hp -l "help,purge" -- "$@")

eval set -- "${PARSED_OPTIONS}"

while true; do
    case "${1}" in
        -h|--help)  usageLong; exit ;;
        -p|--purge) PURGE=true; shift ;;
        --)         shift; break ;;
    esac
done

## SCRIPT FUNCTIONS
########################################

function buildImage() {
    docker build --force-rm --pull --tag ${IMAGE_NAME}:${TAG} ${SCRIPT_DIR}
}

function purgeImage() {
    docker rmi --force ${IMAGE_NAME}:${TAG}
    echo "Purged image: ${IMAGE_NAME}:${TAG}"
}

function main() {
    buildImage; [[ "${PURGE}" == true ]] && purgeImage
    echo "Successfully built ${IMAGE_NAME}:${TAG}"
}

# MAKE IT SO
########################################

main
