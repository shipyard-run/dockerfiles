REPO = shipyardrun/tools
VERSION = $(shell cat ./VERSION)

build_docker:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name multi
	docker buildx use multi
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${REPO}:${VERSION} \
		-f ./Dockerfile \
		. \
		--push
	docker buildx rm multi || true

push_docker:
	echo "Pushed image ${REPO}:${VERSION}