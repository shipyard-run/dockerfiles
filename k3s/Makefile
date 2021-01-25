REPO = shipardrun/k3s
VERSION = $(shell cat ./VERSION)

version:
	echo ${VERSION}

build_docker:
	docker build -t k3stemp .
	docker run --privileged -d --entrypoint="" --name buildk3s k3stemp /bin/containerd
	sleep 5
	docker exec -it buildk3s crictl pull shipyardrun/connector:v0.0.16
	docker exec -it buildk3s crictl pull rancher/coredns-coredns:1.6.9
	docker exec -it buildk3s crictl pull rancher/local-path-provisioner:v0.0.11
	docker exec -it buildk3s crictl pull rancher/metrics-server:v0.3.6
	docker exec -it buildk3s crictl images ls
	docker commit \
		--change "ENV CRI_CONFIG_FILE=\"/var/lib/rancher/k3s/agent/etc/crictl.yaml\"" \
		--change "ENTRYPOINT [\"/bin/k3s\"]" \
		--change "CMD [\"agent\"]" \
		buildk3s ${REPO}:${VERSION}
	docker rm -f buildk3s 


push_docker: build_docker
	docker push ${REPO}:${VERSION}
