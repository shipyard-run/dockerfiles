REPO = shipyardrun/lang
VERSION = go

build_docker:
	docker build -t ${REPO}:${VERSION} .

push_docker: build_docker
	docker push ${REPO}:${VERSION}