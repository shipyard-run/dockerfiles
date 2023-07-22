REPO = shipyardrun/nomad
VERSION = $(shell cat ./VERSION)
SUBVER = 

version:
	echo ${VERSION}

build_docker: build_docker_binaries
# Build a multiarch image and push to remote registry
	docker buildx create --name nomad || true
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${REPO}:${VERSION}${SUBVER} \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
    . \
		--push

build_docker_dev: build_docker_binaries
# Build a amd64 dev version for local testing
	docker buildx build --platform linux/amd64 \
		-t ${REPO}:${VERSION}${SUBVER}.dev \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
    . \
		--load

build_docker_binaries: build_ui
# Cleanup any old files
	docker run --rm \
		-v $(shell pwd):/files \
		alpine \
		sh -c "rm -rf /files/nomad-build"

# Build the application for all archs
	docker build \
		-t nomad-build \
    -f ./Dockerfile.build \
		--build-arg NOMAD_VERSION=${VERSION} \
    .

# Copy the compiled files
	docker run --rm \
		-v $(shell pwd)/nomad-build:/files \
		nomad-build \
		/bin/bash -c "cp -R /go/src/github.com/hashicorp/nomad/out /files"


build_ui:
# Cleanup any old files
	docker run --rm \
		-v $(shell pwd):/files \
		alpine \
		sh -c "rm -rf /files/ember-build"

# Build the ember setup
	docker build \
		-t ember-build \
		-f Dockerfile.ember \
		--build-arg NOMAD_VERSION=${VERSION} \
		.

# Copy the compiled files
	docker run --rm \
		-v $(shell pwd)/ember-build:/files \
		ember-build \
		/bin/bash -c "cp -R /go/src/github.com/hashicorp/nomad/ui /files"

clean_context:
	docker buildx rm nomad

push_docker:
# docker push ${REPO}:${VERSION}
	echo "Pushed image ${REPO}:${VERSION}${SUBVER}"
