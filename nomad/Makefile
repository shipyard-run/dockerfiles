REPO = shipyardrun/nomad
VERSION = v0.10.2

build_docker:
	docker build -t ${REPO}:${VERSION} .

push_docker: build_docker
	docker push ${REPO}:${VERSION}