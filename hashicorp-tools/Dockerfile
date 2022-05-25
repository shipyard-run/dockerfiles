FROM shipyardrun/tools:v0.6.0 as base

ENV TERM=xterm-256color

ENV CONSUL_VERSION=1.12.0
ENV NOMAD_VERSION=1.3.1
ENV VAULT_VERSION=1.10.2
ENV TERRAFORM_VERSION=1.1.9
ENV WAYPOINT_VERSION=0.8.1
ENV NOMAD_PACK_VERSION=0.0.1-techpreview2


ENV PATH="$PATH:/usr/tools"
ENV DEBIAN_FRONTEND=noninteractive

FROM base AS image-amd64

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

# Install Terraform
RUN curl -sL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
  unzip terraform.zip && \
  mv terraform /usr/tools && \
  rm terraform.zip

# Install Waypoint
RUN curl -sL https://releases.hashicorp.com/waypoint/${WAYPOINT_VERSION}/waypoint_${WAYPOINT_VERSION}_linux_amd64.zip -o waypoint.zip && \
  unzip waypoint.zip && \
  mv waypoint /usr/tools && \
  rm waypoint.zip

# Install Nomad Pack
RUN curl -sL https://releases.hashicorp.com/nomad-pack/${NOMAD_PACK_VERSION}/nomad-pack_${NOMAD_PACK_VERSION}_linux_amd64 -o nomad-pack.zip && \
  unzip nomad-pack.zip && \
  mv nomad-pack /usr/tools && \
  rm nomad-pack.zip

FROM base AS image-arm64

# Install Consul CLI
RUN curl -sL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_arm64.zip -o consul.zip && \
    unzip consul.zip && \
    mv consul /usr/tools && \
    rm consul.zip

# Install Nomad CLI
RUN curl -sL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_arm64.zip -o nomad.zip && \
    unzip nomad.zip && \
    mv nomad /usr/tools && \
    rm nomad.zip

# Install Vault CLI
RUN curl -sL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_arm64.zip -o vault.zip && \
    unzip vault.zip && \
    mv vault /usr/tools && \
    rm vault.zip

# Install Terraform
RUN curl -sL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_arm64.zip -o terraform.zip && \
  unzip terraform.zip && \
  mv terraform /usr/tools && \
  rm terraform.zip

# Install Waypoint
RUN curl -sL https://releases.hashicorp.com/waypoint/${WAYPOINT_VERSION}/waypoint_${WAYPOINT_VERSION}_linux_arm.zip -o waypoint.zip && \
  unzip waypoint.zip && \
  mv waypoint /usr/tools && \
  rm waypoint.zip

# Install Nomad Pack
RUN curl -sL https://releases.hashicorp.com/nomad-pack/${NOMAD_PACK_VERSION}/nomad-pack_${NOMAD_PACK_VERSION}_linux_arm64 -o nomad-pack.zip && \
  unzip nomad-pack.zip && \
  mv nomad-pack /usr/tools && \
  rm nomad-pack.zip

FROM image-${TARGETARCH}

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDARCH

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM $TARGETARCH $TARGETVARIANT"  
