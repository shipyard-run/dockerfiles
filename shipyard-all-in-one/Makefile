REPO = shipyardrun/shipyard-all-in-one
VERSION = $(shell cat ./VERSION)

version:
	echo ${VERSION}

build_docker:
	docker build -t ${REPO}:${VERSION} .

push_docker: build_docker
	docker push ${REPO}:${VERSION}
