FROM golang:1.17.10 as go_build

ARG TARGETARCH
ARG NOMAD_VERSION

WORKDIR /go/src/github.com/hashicorp/

RUN git config --global user.email "mail@shipyard.run" && \
    git config --global user.name "Shipyard Bot"

RUN git clone https://github.com/hashicorp/nomad.git && \
    cd nomad && \
    git checkout v${NOMAD_VERSION}

WORKDIR /go/src/github.com/hashicorp/nomad

RUN rm -rf /go/src/github.com/hashicorp/nomad/ui 
COPY ./ember-build/ui /go/src/github.com/hashicorp/nomad/ui

COPY ./0001-Remove-fingerprint-checks-for-bridge.patch ./

RUN git am ./0001-Remove-fingerprint-checks-for-bridge.patch
RUN make bootstrap
RUN make static-assets
RUN make NOMAD_UI_TAG="ui" dev

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker LANG=C.UTF-8

# Versions to install
ENV CONSUL_VERSION=1.12.0
ENV CNI_PLUGINS=1.1.1

# set default env vars so supervisor
# does not crash on start
ENV CONSUL_SERVER=localhost
ENV CONSUL_DATACENTER=dc1

ARG TARGETARCH
ARG NOMAD_VERSION

# Enable all repositories.
RUN apt-get update && \
    apt-get install -y \
    software-properties-common supervisor rsyslog iproute2 python python-apt sudo bash ca-certificates \
    curl net-tools jq unzip vim dnsutils iputils-ping socat \
    iptables \
    apt-transport-https \
    gnupg \
    lsb-release \
    wget \
    qemu-system-x86 \
    udhcpd \
    iproute2

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
      "deb [arch=${TARGETARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# https://github.com/docker/docker/tree/master/hack/dind
ENV DIND_COMMIT 42b1175eda071c0e9121e1d64345928384a93df1

RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/dockerd-entrypoint.sh

# Add java
RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='3447ec27a6dbd4f3a6180a0d4371bb09aa428c16eea9983e515a7400cc9f5c85'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jdk_aarch64_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       armhf|armv7l) \
         ESUM='20fc395d8ea2659e6407cd4ec233dc4399f61b7610f3a16495deb23c1e3b81df'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jdk_arm_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='8d8e35ca5a7e24f16384bf32b110562921c19b4cfe65969980937bf879462bc6'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jdk_ppc64le_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       s390x) \
         ESUM='421cd44661cdbf0c2da79ab3104c81a1fa171b974038e55b1b3d4a042865588f'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jdk_s390x_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='7fdda042207efcedd30cd76d6295ed56b9c2e248cb3682c50898a560d4aa1c6f'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jdk_x64_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /usr/lib/jvm/openjdk; \
    cd /usr/lib/jvm/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/usr/lib/jvm/openjdk \
    PATH="/usr/lib/jvm/openjdk/bin:$PATH"

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

# Creat the nomad data directory
RUN mkdir -p /var/lib/nomad

# Add the nomad config
COPY ./nomad_config.hcl /etc/nomad.d/config.hcl
COPY ./start_nomad.sh /etc/nomad.d/start_nomad.sh
RUN chmod +x /etc/nomad.d/start_nomad.sh

# Setup bash and supervisord etc
RUN sed -i 's/\/bin\/ash/\/bin\/bash/g' /etc/passwd

# Setup the supervisor d file
COPY supervisor.ini /etc/supervisor/conf.d/supervisor.conf

# Run supervisord
RUN sed -i '/\[supervisord\]/a nodaemon=true' /etc/supervisor/supervisord.conf

VOLUME /var/lib/docker

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]