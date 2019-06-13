.DEFAULT_GOAL=build-all
HAS_DOCKER := $(shell which docker 2>/dev/null)
REPO_ROOT=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build-target-exists:
	@mkdir -p $(REPO_ROOT)/build

check-docker:
ifndef HAS_DOCKER
	$(error "This command requires Docker.")
endif

build-go: build-target-exists
	@mkdir -p $(REPO_ROOT)/build
	@echo "Building tools.."
	$(MAKE) -C tools
	@echo "Building middleware.."
	$(MAKE) -C middleware

build-all: build-target-exists docker-build-go
	@echo "Building armbian.."
	$(MAKE) -C armbian

clean:
	$(MAKE) -C armbian clean
	rm -rf $(REPO_ROOT)/build

dockerinit: check-docker
	docker build --tag digitalbitbox/bitbox-base .

docker-build-go: dockerinit
	@echo "Building tools and middleware inside Docker container.."
	docker run \
	       --rm \
	       --tty \
	       -v $(REPO_ROOT):/opt/go/src/github.com/digitalbitbox/bitbox-base \
	  digitalbitbox/bitbox-base bash -c " \
	      make -C tools && \
	      make -C middleware"

ci: dockerinit
	./scripts/travis-ci.sh

docker-jekyll:
	@echo "Starting docker-jekyll server at localhost:4000.."
	# Note: we need to remove the directory below (if present) from the
	# Armbian build process for unknown reasons, or the Jekyll command fails with:
	# xxx
	rm -rf $(REPO_ROOT)/armbian/armbian-build/packages/bsp/common/
	docker run --rm -it -p 4000:4000 -v $(shell pwd):/srv/jekyll \
	       jekyll/jekyll:pages jekyll serve --watch --incremental
