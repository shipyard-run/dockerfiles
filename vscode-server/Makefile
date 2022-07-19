REPO = shipyardrun/vscode-server
VERSION = base-$(shell cat ./VERSION)

build-local:
	docker build -t shipyardrun/vscode-server:dev .

build-docker:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name vscode || true
	docker buildx use vscode
	docker buildx inspect --bootstrap
	docker buildx build --platform linux/arm64,linux/amd64 \
		-t ${REPO}:${VERSION} \
    -f ./Dockerfile \
		--no-cache \
    	. \
		--push

push-docker:
	echo "Pushed image"
