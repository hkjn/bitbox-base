.DEFAULT_GOAL := aarch64
REPO_ROOT=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/..
SHELL:=/bin/bash

check-go-env:
	@echo "Checking that environment supports Go builds.."
	@$(REPO_ROOT)/scripts/check-go-env.sh "$(REPO_ROOT)"

ci:
	cd $(REPO_ROOT)/middleware/src
	golangci-lint run

envinit:
	@echo "Initializing Go environment.."
	$(REPO_ROOT)/middleware/scripts/envinit.sh

fetch-deps:
	@echo "Fetching dependencies.."
	go get -v ./...

native: check-go-env fetch-deps ci
	go install $(REPO_ROOT)/middleware/cmd/middleware

aarch64: check-go-env fetch-deps ci
	GOARCH=arm64 go install $(REPO_ROOT)/middleware/cmd/middleware
	cp ${GOPATH}/bin/linux_arm64/middleware $(REPO_ROOT)/build/base-middleware
