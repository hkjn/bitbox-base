#!/usr/bin/env bash
#
# Run CI scripts to build / test project.
#
set -euo pipefail

# TODO(hkjn): We could 'make build-all' here if we can resolve
# remaining issues with building Armbian images in a dockerized
# workflow on Travis:
# https://github.com/digitalbitbox/bitbox-base/issues/39#issuecomment-501343881
# xx: find the reason why travis fails to run the armbian container (via build.sh -> compile.sh):o
# Successfully built b1561d8cbb3b
# Successfully tagged armbian:latest
# [ o.k. ] Running the container 
# docker: Error response from daemon: create ./: "./" includes invalid characters for a local volume name, only "[a-zA-Z0-9][a-zA-Z0-9_.-]" are allowed. If you intended to pass a host directory, use absolute path.
# See 'docker run --help'.
# [ error ] Docker command failed, check syntax or version support. Error code:   [ 125 ]
# L78 of config-docker.conf logs 'Running the container' just before the error:
# docker run "${DOCKER_FLAGS[@]}" -it armbian docker-guest "$@"

TRAVIS_BUILD_DIR=${TRAVIS_BUILD_DIR:-"$(pwd)"}
make build-all
