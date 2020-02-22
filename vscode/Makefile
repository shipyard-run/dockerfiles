REPO = shipyardrun/code
VERSION = latest

build_docker:
	docker build -t ${REPO}:${VERSION} .

push_docker: build_docker
	docker push ${REPO}:${VERSION}

build_solo_docker:
	docker build -f ./Dockerfile-gloo -t ${REPO}:solo .

push_solo_docker: build_docker
	docker push ${REPO}:solo