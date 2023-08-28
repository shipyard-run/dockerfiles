REPO = shipyardrun/nomad
VERSION = $(shell cat ./VERSION)
SUBVER = 

version:
	echo ${VERSION}

build_docker:
# Build a multiarch image and push to remote registry
	docker buildx create --name nomad --use || true
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${REPO}:${VERSION}${SUBVER} \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
    . \
		--push

build_docker_dev:
# Build a amd64 dev version for local testing
	docker buildx build --platform linux/amd64 \
		-t ${REPO}:${VERSION}${SUBVER}.dev \
		--build-arg NOMAD_VERSION=${VERSION} \
    -f ./Dockerfile \
    . \
		--load

clean_context:
	docker buildx rm nomad

push_docker:
# docker push ${REPO}:${VERSION}
	echo "Pushed image ${REPO}:${VERSION}${SUBVER}"
