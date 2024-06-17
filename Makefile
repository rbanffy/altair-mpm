.PHONY: help build push_images create_manifest
.DEFAULT_GOAL := help

SHELL = /bin/sh
BUILD_DIR = build

ARCHITECTURES = amd64 arm64 arm/v6 arm/v7 s390x ppc64le

BRANCH = $(shell git branch --show-current)

ifeq ($(BRANCH),main)
	IMAGE_TAG = stable
else ifeq ($(BRANCH),develop)
	IMAGE_TAG = latest
else
	IMAGE_TAG = $(BRANCH)
endif

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z0-9_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help: ## Displays this message.
	@echo "Please use \`make <target>\` where <target> is one of:"
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

build: ## Builds the Docker images
	docker build -t ${USER}/altair-mpm:${IMAGE_TAG}-amd64 --platform=linux/amd64 --file ./Dockerfile --progress plain .
	docker build -t ${USER}/altair-mpm:${IMAGE_TAG}-arm64 --platform=linux/arm64 --file ./Dockerfile --progress plain .
	docker build -t ${USER}/altair-mpm:${IMAGE_TAG}-armv6 --platform=linux/arm/v6 --file ./Dockerfile --progress plain .
	docker build -t ${USER}/altair-mpm:${IMAGE_TAG}-armv7 --platform=linux/arm/v7 --file ./Dockerfile --progress plain .
	docker build -t ${USER}/altair-mpm:${IMAGE_TAG}-s390x --platform=linux/s390x --file ./Dockerfile --progress plain .
	docker build -t ${USER}/altair-mpm:${IMAGE_TAG}-ppc64le --platform=linux/ppc64le --file ./Dockerfile --progress plain .

push_images: build ## Uploads the local docker images
	docker image push ${USER}/altair-mpm:${IMAGE_TAG}-amd64
	docker image push ${USER}/altair-mpm:${IMAGE_TAG}-arm64
	docker image push ${USER}/altair-mpm:${IMAGE_TAG}-armv6
	docker image push ${USER}/altair-mpm:${IMAGE_TAG}-armv7
	docker image push ${USER}/altair-mpm:${IMAGE_TAG}-s390x
	docker image push ${USER}/altair-mpm:${IMAGE_TAG}-ppc64le

create_manifest: push_images ## Uploads the manifest
	docker manifest create ${USER}/altair-mpm:${IMAGE_TAG} \
		--amend ${USER}/altair-mpm:${IMAGE_TAG}-amd64 \
		--amend ${USER}/altair-mpm:${IMAGE_TAG}-arm64 \
		--amend ${USER}/altair-mpm:${IMAGE_TAG}-armv6 \
		--amend ${USER}/altair-mpm:${IMAGE_TAG}-armv7 \
		--amend ${USER}/altair-mpm:${IMAGE_TAG}-s390x \
		--amend ${USER}/altair-mpm:${IMAGE_TAG}-ppc64le
	docker manifest push ${USER}/altair-mpm:${IMAGE_TAG}
