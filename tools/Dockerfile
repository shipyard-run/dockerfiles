FROM ubuntu:latest

ENV TERM=xterm-256color
ENV KUBECTL_VERSION=latest
ENV HELM_VERSION=v3.2.0
ENV DOCKER_VERSION=18.09.9
ENV CONSUL_VERSION=1.7.2
ENV NOMAD_VERSION=0.11.1
ENV VAULT_VERSION=1.4.0
ENV SHIPYARD_VERSION=0.0.24

ENV PATH="$PATH:/usr/tools"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      curl \
      zip \
      git \
      vim \
      net-tools \
      dnsutils \
      ngrep \
      iputils-ping \
      gnupg-agent \
      jq && \
      apt-get clean && \
      apt-get autoremove --purge && \
      rm -rf /var/lib/apt/lists/*

# Copy installed tools to a specific directory, makes it easier to copy the tools
# when this image is used as the base for another.
RUN mkdir /usr/tools

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | \
tar zxvf - --strip 1 -C /usr/tools docker/docker

# Install Consul CLI
RUN curl -sL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip && \
    unzip consul.zip && \
    mv consul /usr/tools && \
    rm consul.zip

# Install Nomad CLI
RUN curl -sL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip && \
    unzip nomad.zip && \
    mv nomad /usr/tools && \
    rm nomad.zip

# Install Vault CLI
RUN curl -sL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o vault.zip && \
    unzip vault.zip && \
    mv vault /usr/tools && \
    rm vault.zip

# Install Kubectl
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/tools

# Install Helm
RUN curl -sL https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz -o ./helm.tar.gz && \
    tar -xzf ./helm.tar.gz && \
    mv ./linux-amd64/helm /usr/tools && \
    rm ./helm.tar.gz

# Install Shipyard
RUN curl -sL https://github.com/shipyard-run/shipyard/releases/download/v${SHIPYARD_VERSION}/shipyard_${SHIPYARD_VERSION}_Linux_x86_64.tar.gz -o shipyard.tar.gz && \
    tar -xzf shipyard.tar.gz && \
    mv shipyard /usr/tools && \
    rm shipyard.tar.gz
