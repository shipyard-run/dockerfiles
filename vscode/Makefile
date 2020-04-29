REPO = shipyardrun/code
VERSION = latest

build_docker:
	docker build -t ${REPO}:${VERSION} .

push_docker: build_docker
	docker push ${REPO}:${VERSION}

build_docker_go:
	cd ./dev-go && docker build -t ${REPO}:go-${VERSION} .

push_docker_go: build_docker_go
	docker push ${REPO}:${VERSION}

build_solo_docker:
	docker build -f ./Dockerfile-gloo -t ${REPO}:solo .

push_solo_docker: build_docker
	docker push ${REPO}:solo

build_datawire_docker:
	docker build -f ./Dockerfile-datawire -t ${REPO}:datawire .

push_datawire_docker: build_docker
	docker push ${REPO}:datawire