#!/bin/bash

# BitBox Base: build base-middleware
#
# Script to automate the build process of the base-middleware service for the BitBox Base.
#
set -eu

# Target architecture. Defaults to arm64, which is the CPU architecture of the BitBox Base.
GOARCH=${GOARCH:-"arm64"}

function usage() {
	echo "Build base-middleware for BitBox Base"
	echo "Usage: ${0} [update]"
}

function build() {
	if ! which go >/dev/null 2>&1; then
		echo
		echo "The environment does not have the `go` toolchain installed. Please check documentation at"
		echo "https://digitalbitbox.github.io/bitbox-base"
		echo
		return 1
	fi

	go build -v -o ../build/base-middleware ./src/
}


ACTION=${1:-"build"}

if ! [[ "${ACTION}" =~ ^(build|update|clean)$ ]]; then
	usage
	exit 1
fi


case ${ACTION} in
	build)
		echo "Building middleware.."
		build
		if [[ $? -ne 0 ]]; then
			exit 1
		fi
		;;

	clean)
		rm -rf ../build/base-middleware
		;;

esac
