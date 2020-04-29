REPO = shipyardrun/tools
VERSION = v0.0.4

build_docker:
	docker build -t ${REPO}:${VERSION} .

push_docker: build_docker
	docker push ${REPO}:${VERSION}

build_docker_dw:
	docker build -t ${REPO}:datawire-${VERSION} -f ./Dockerfile-datawire .

push_docker_dw: build_docker_dw
	docker push ${REPO}:datawire-${VERSION}