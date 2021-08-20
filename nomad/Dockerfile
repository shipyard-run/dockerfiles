FROM node:14.17.5 as ui_build

ARG TARGETARCH
ARG NOMAD_VERSION

WORKDIR /go/src/github.com/hashicorp/

RUN git config --global user.email "mail@shipyard.run" && \
    git config --global user.name "Shipyard Bot"

RUN git clone https://github.com/hashicorp/nomad.git && \
    cd nomad && \
    git checkout v${NOMAD_VERSION}

WORKDIR /go/src/github.com/hashicorp/nomad

RUN make ember-dist


FROM golang:1.16.3 as go_build

ARG TARGETARCH
ARG NOMAD_VERSION

WORKDIR /go/src/github.com/hashicorp/

RUN git config --global user.email "mail@shipyard.run" && \
    git config --global user.name "Shipyard Bot"


WORKDIR /go/src/github.com/hashicorp/nomad

COPY --from=ui_build /go/src/github.com/hashicorp/nomad /go/src/github.com/hashicorp/nomad

COPY ./0001-Remove-fingerprint-checks-for-bridge.patch ./

RUN git am ./0001-Remove-fingerprint-checks-for-bridge.patch && \
    make bootstrap && \
    make static-assets && \
    make NOMAD_UI_TAG="ui" dev


FROM shipyardrun/ubuntu:20.04

ARG TARGETARCH
ARG NOMAD_VERSION

# Versions to install
ENV CONSUL_VERSION=1.10.1
ENV CNI_PLUGINS=1.0.0

# set default env vars so supervisor
# does not crash on start
ENV CONSUL_SERVER=localhost
ENV CONSUL_DATACENTER=dc1

RUN apt update && apt install -y \
    curl \
    iptables \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
      "deb [arch=${TARGETARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Force storage driver to use vfs
RUN mkdir -p /etc/docker
RUN echo "{ \ 
    \"storage-driver\": \"vfs\" \
    }" > /etc/docker/daemon.json

# Fetch Consul
RUN curl -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${TARGETARCH}.zip -o /tmp/consul.zip && \
    cd /tmp && \
    unzip consul.zip && \
    mv consul /usr/bin/consul && \
    chmod +x /usr/bin/consul

# Create the Consul config directory
RUN mkdir -p /etc/consul.d/data
RUN mkdir -p /etc/consul.d/config

# Add the default consul config
COPY ./consul_config.hcl /etc/consul.d/config/config.hcl

# Fetch the nomad binary
COPY --from=go_build /go/src/github.com/hashicorp/nomad/pkg/linux_${TARGETARCH}/nomad /usr/bin/nomad
#RUN curl -L https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_${TARGETARCH}.zip -o /tmp/nomad.zip && \
#    unzip /tmp/nomad.zip -d /tmp && \
#    mv /tmp/nomad /usr/bin/nomad

# Install the CNI Plugins
RUN curl -L https://github.com/containernetworking/plugins/releases/download/v${CNI_PLUGINS}/cni-plugins-linux-${TARGETARCH}-v${CNI_PLUGINS}.tgz -o /tmp/cni.tgz && \
    mkdir -p /opt/cni/bin && \
    tar -C /opt/cni/bin -xzf /tmp/cni.tgz

# Add the nomad config
COPY ./nomad_config.hcl /etc/nomad.d/config.hcl
COPY ./start_nomad.sh /etc/nomad.d/start_nomad.sh
RUN chmod +x /etc/nomad.d/start_nomad.sh

# Setup bash and supervisord etc
RUN sed -i 's/\/bin\/ash/\/bin\/bash/g' /etc/passwd

# Add the systemd units
COPY nomad.service /etc/systemd/system/nomad.service
COPY consul.service /etc/systemd/system/consul.service

RUN ln -s /etc/systemd/system/nomad.service /etc/systemd/system/multi-user.target.wants/nomad.service && \
    ln -s /etc/systemd/system/consul.service /etc/systemd/system/multi-user.target.wants/consul.service

CMD ["/sbin/init", "--log-target=journal"]