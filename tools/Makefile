REPO = shipyardrun/tools
VERSION = latest

build_docker:
	docker build -t ${REPO}:${VERSION} --squash .

push_docker: build_docker
	docker push ${REPO}:${VERSION}