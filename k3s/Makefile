REPO = shipyardrun/k3s
VERSION = $(shell cat ./VERSION)

version:
	echo ${VERSION}

build_docker:
	docker build -t ${REPO}:${VERSION} --build-arg K8S_VERSION=${VERSION} .

push_docker:
	docker push ${REPO}:${VERSION}
