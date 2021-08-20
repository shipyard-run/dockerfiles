REPO = shipyardrun/nomad
VERSION = $(shell cat ./VERSION)

version:
	echo ${VERSION}

build_docker:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name nomad || true
	docker buildx use nomad
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${REPO}:${VERSION} \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
    . \
		--push

build_docker_dev:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name nomad || true
	docker buildx use nomad
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/amd64 \
		-t ${REPO}:dev \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
    . \
		--load

clean_context:
	docker buildx rm nomad

push_docker:
# docker push ${REPO}:${VERSION}
	echo "Pushed image ${REPO}:${VERSION}"