FROM ubuntu:latest as base

ENV TERM=xterm-256color

ENV PATH="$PATH:/usr/tools"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
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

# Copy AMD binaries
FROM base AS image-amd64-

ENV KUBECTL_VERSION=latest
ENV HELM_VERSION=v3.7.2
ENV DOCKER_VERSION=20.10.9
ENV SHIPYARD_VERSION=0.3.54

# Copy installed tools to a specific directory, makes it easier to copy the tools
# when this image is used as the base for another.
RUN mkdir /usr/tools

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | \
tar zxvf - --strip 1 -C /usr/tools docker/docker


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


# Copy Arm 8 binaries
FROM base AS image-arm64-

ENV KUBECTL_VERSION=latest
ENV HELM_VERSION=v3.7.2
ENV DOCKER_VERSION=20.10.9
ENV SHIPYARD_VERSION=0.3.38

# Copy installed tools to a specific directory, makes it easier to copy the tools
# when this image is used as the base for another.
RUN mkdir /usr/tools

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/aarch64/docker-${DOCKER_VERSION}.tgz | \
tar zxvf - --strip 1 -C /usr/tools docker/docker


# Install Kubectl
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/arm64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/tools

# Install Helm
RUN curl -sL https://get.helm.sh/helm-$HELM_VERSION-linux-arm64.tar.gz -o ./helm.tar.gz && \
    tar -xzf ./helm.tar.gz && \
    mv ./linux-arm64/helm /usr/tools && \
    rm ./helm.tar.gz

# Install Shipyard
RUN curl -sL https://github.com/shipyard-run/shipyard/releases/download/v${SHIPYARD_VERSION}/shipyard_${SHIPYARD_VERSION}_linux_arm64.tar.gz -o shipyard.tar.gz && \
    tar -xzf shipyard.tar.gz && \
    mv shipyard /usr/tools && \
    rm shipyard.tar.gz


FROM image-${TARGETARCH}-${TARGETVARIANT}

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDARCH

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM $TARGETARCH $TARGETVARIANT"  
