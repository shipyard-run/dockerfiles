FROM shipyardrun/tools:latest as tools
FROM ubuntu:latest as node

ENV EXT_HCL_VERSION=0.0.5
ENV EXT_YAML_VERSION=0.7.2
ENV EXT_NORD_VERSION=0.12.0
ENV EXT_GO_VERSION=0.13.1

# Install bsdtar
RUN apt-get update && apt-get install -y git bsdtar curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_13.x -o /tmp/nodesetup.sh && \
      bash /tmp/nodesetup.sh && \
      apt-get install -y nodejs

# Extensions to code-server
RUN mkdir -p /root/.local/share/code-server/extensions

# VSCode Go
RUN curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/Go/${EXT_GO_VERSION}/vspackage | \
       bsdtar -xvf - extension && \
       mv ./extension /root/.local/share/code-server/extensions/ms-vscode.go-${EXT_GO_VERSION} && \
       cd /root/.local/share/code-server/extensions/ms-vscode.go-${EXT_GO_VERSION} && \
       npm i

# Formatting for HCL
 RUN curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/wholroyd/vsextensions/HCL/${EXT_HCL_VERSION}/vspackage | \
      bsdtar -xvf - extension && \
      mv ./extension /root/.local/share/code-server/extensions/wholroyd.HCL-${EXT_HCL_VERSION} && \
      cd /root/.local/share/code-server/extensions/wholroyd.HCL-${EXT_HCL_VERSION} && \
      npm i

# YAML formatting
 RUN curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/redhat/vsextensions/vscode-yaml/${EXT_YAML_VERSION}/vspackage | \
      bsdtar -xvf - extension && \
      mv ./extension /root/.local/share/code-server/extensions/redhat.vscode-yaml-${EXT_YAML_VERSION} && \
      cd /root/.local/share/code-server/extensions/redhat.vscode-yaml-${EXT_YAML_VERSION} && \
      npm i

# NORD theme
 RUN curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/arcticicestudio/vsextensions/nord-visual-studio-code/${EXT_NORD_VERSION}/vspackage | \
       bsdtar -xvf - extension && \
       mv ./extension /root/.local/share/code-server/extensions/arcticicestudio.nord-visual-studio-code-${EXT_NORD_VERSION} && \
       cd /root/.local/share/code-server/extensions/arcticicestudio.nord-visual-studio-code-${EXT_NORD_VERSION} && \
       npm i

FROM codercom/code-server:3.0.2

# Make the default user admin
USER root

ENV GOPATH="/go"
ENV PATH="$PATH:/usr/local/go/bin:$GOPATH/bin;/usr/tools"
ENV GO111MODULE="on"
ENV SHELL=/bin/bash
ENV GO_VERSION=1.14.1

# Add Go and GCC
RUN apt-get update && apt-get install -y git curl gcc && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Go and packages for VSCode
RUN curl -sL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go${GO_VERSION}.tar.gz && \
    tar -C /usr/local -xzf /tmp/go${GO_VERSION}.tar.gz && \
    rm /tmp/go${GO_VERSION}.tar.gz && \
    go get github.com/mdempsky/gocode && \
    go get github.com/uudashr/gopkgs/v2/cmd/gopkgs && \
    go get github.com/ramya-rao-a/go-outline && \
    go get github.com/acroca/go-symbols && \
    go get golang.org/x/tools/cmd/guru && \
    go get golang.org/x/tools/cmd/gorename && \
    go get github.com/cweill/gotests/... && \
    go get github.com/fatih/gomodifytags && \
    go get github.com/josharian/impl && \
    go get github.com/davidrjenni/reftools/cmd/fillstruct && \
    go get github.com/haya14busa/goplay/cmd/goplay && \
    go get github.com/godoctor/godoctor && \
    go get github.com/stamblerre/gocode && \
    go get github.com/rogpeppe/godef && \
    go get golang.org/x/tools/cmd/goimports && \
    go get golang.org/x/lint/golint && \
    go get golang.org/x/tools/gopls && \
    go get github.com/go-delve/delve/cmd/dlv

# Add the extensions
COPY --from=node /root/.local/share/code-server/extensions /extensions-cache

# Add the default tools
COPY --from=tools /usr/tools /usr/tools

ENV VER=abc

# Add the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /root

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]