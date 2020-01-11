# Nomad

This Dockerfile builds a "fat" Nomad container, the container is self contained with the following software:
* Nomad
* Docker
* Consul
* Envoy

The container has its own Docker daemon so any running jobs will not be executed on the client.

## Building

To build the image run the following command:

```
make build_docker
```

## Running

You can run the image using the following command

```
docker run -it --privileged  -p 4646:4646 shipyardrun/nomad:v0.10.2
```

Then run a job:

```
nomad status

nomad run example
==> Monitoring evaluation "7444bbfc"
    Evaluation triggered by job "example"
    Evaluation within deployment: "fc9184d1"
    Allocation "bcf75f87" created: node "97deb09d", group "cache"
    Evaluation status changed: "pending" -> "complete"
==> Evaluation "7444bbfc" finished with status "complete"

nomad status
ID       Type     Priority  Status   Submit Date
example  service  50        running  2020-01-11T08:58:58Z
```
