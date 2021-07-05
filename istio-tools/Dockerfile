FROM shipyardrun/tools:v0.5.0 as base

ENV TERM=xterm-256color

ENV ISTIO_VERSION=1.10.2

ENV PATH="$PATH:/usr/tools"
ENV DEBIAN_FRONTEND=noninteractive

FROM base AS image-amd64-

# Install Istio
RUN curl -sL https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux-amd64.tar.gz -o istio.tar.gz && \
    tar -xzf istio.tar.gz && \
    mv istio-${ISTIO_VERSION} /usr/tools/istio && \
    rm istio.tar.gz

FROM base AS image-arm64-

# Install Istio
RUN curl -sL https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux-arm64.tar.gz -o istio.tar.gz && \
    tar -xzf istio.tar.gz && \
    mv istio-${ISTIO_VERSION} /usr/tools/istio && \
    rm istio.tar.gz

FROM image-${TARGETARCH}-${TARGETVARIANT}

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDARCH

ENV PATH="$PATH:/usr/tools:/usr/tools/istio/bin"

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM $TARGETARCH $TARGETVARIANT"  