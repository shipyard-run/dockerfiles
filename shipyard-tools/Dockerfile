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
ENV HELM_VERSION=v3.14.4
ENV DOCKER_VERSION=26.0.1
ENV JUMPPAD_VERSION=0.11.0

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

# Install Jumppad
RUN curl -sL https://github.com/jumppad-labs/jumppad/releases/download/${JUMPPAD_VERSION}/jumppad_${JUMPPAD_VERSION}_linux_x86_64.tar.gz -o jumppad.tar.gz && \
    tar -xzf jumppad.tar.gz && \
    mv jumppad /usr/tools && \
    rm jumppad.tar.gz


# Copy Arm 8 binaries
FROM base AS image-arm64-

ENV KUBECTL_VERSION=latest
ENV HELM_VERSION=v3.14.4
ENV DOCKER_VERSION=26.0.1
ENV JUMPPAD_VERSION=0.11.0

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

# Install Jumppad
RUN curl -sL https://github.com/jumppad-labs/jumppad/releases/download/${JUMPPAD_VERSION}/jumppad_${JUMPPAD_VERSION}_linux_arm64.tar.gz -o jumppad.tar.gz && \
    tar -xzf jumppad.tar.gz && \
    mv jumppad /usr/tools && \
    rm jumppad.tar.gz

FROM image-${TARGETARCH}-${TARGETVARIANT}

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDARCH

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM $TARGETARCH $TARGETVARIANT"  
