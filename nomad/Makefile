REPO = shipyardrun/nomad
VERSION = $(shell cat ./VERSION)

version:
	echo ${VERSION}

build_docker: build_ui
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name nomad || true
	docker buildx use nomad
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${REPO}:${VERSION} \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
		--no-cache \
    . \
		--push

build_docker_dev: build_ui
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name nomad || true
	docker buildx use nomad
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/amd64 \
		-t ${REPO}:${VERSION}-dev \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
		--no-cache \
    . \
		--load

build_ui:
	docker run --rm \
		-v $(shell pwd):/files \
		alpine \
		sh -c "rm -rf /files/ember-build"

# Build the ember setup
	docker build -t ember-build \
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
	echo "Pushed image ${REPO}:${VERSION}"