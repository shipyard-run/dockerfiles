FROM ubuntu:latest

ENV TERM=xterm-256color
ENV KUBECTL_VERSION=latest
ENV HELM_VERSION=v3.0.2
ENV DOCKER_VERSION=18.03.1-ce
ENV CONSUL_VERSION=1.6.1
ENV VAULT_VERSION=1.3.1

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
      apt-get autoremove --purge

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz | \
tar zxvf - --strip 1 -C /usr/bin docker/docker

# Install Consul CLI
RUN curl -sL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip && \
    unzip consul.zip && \
    mv consul /usr/local/bin && \
    rm consul.zip

# Install Vault CLI
RUN curl -sL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o vault.zip && \
    unzip vault.zip && \
    mv vault /usr/local/bin && \
    rm vault.zip

# Install Kubectl
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin

# Install Helm
RUN curl -sL https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz -o ./helm.tar.gz && \
    tar -xzf ./helm.tar.gz && \
    mv ./linux-amd64/helm /usr/local/bin && \
    rm ./helm.tar.gz