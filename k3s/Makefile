REPO = shipyardrun/k3s
VERSION = $(shell cat ./VERSION)

version:
	echo ${VERSION}

build_docker:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name multi || true
	docker buildx use multi
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/arm/v7,linux/arm64,linux/amd64 \
		-t ${REPO}:${VERSION} \
		--build-arg K8S_VERSION=${VERSION} \
    -f ./Dockerfile \
    . \
		--push
	docker buildx rm multi

push_docker:
# docker push ${REPO}:${VERSION}
	echo "Pushed image ${REPO}:${VERSION}"
