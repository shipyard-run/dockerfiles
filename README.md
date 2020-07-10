# Dockerfiles
Dockerfiles for Shipyard

## Building
To build images for the Dockerfiles defined in this repository create and push a new tag

```
git tag v0.1.0
git push origin v0.1.0
```

All images will be built, tagged and pushed to Dockerhub

## Images

### Tools [./tools/Dockerfile](./tools/Dockerfile)
This image is the main tools image for Shipyard, it contains tools such as Consul, Nomad, Kubectl, etc.

### Tools - Datawire [./tools/Dockerfile-datawire](./tools/Dockerfile-solo) 
This image inherits the main tools image and adds `edgectl`

### Tools - Solo [./tools/Dockerfile-solo](./tools/Dockerfile-solo) 
This image inherits the main tools image and adds tools specific to the Solo product suite: Squash, Gloo, Loop, WASME
