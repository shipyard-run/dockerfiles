FROM codercom/code-server:latest AS codercom

FROM ubuntu:latest as node

ENV EXT_SQUASH_VERSION=0.5.18
ENV EXT_HCL_VERSION=0.0.5
ENV EXT_YAML_VERSION=0.7.2
ENV EXT_NORD_VERSION=0.12.0
ENV EXT_GO_VERSION=0.13.0

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

 RUN curl -JL  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ilevine/vsextensions/squash/${EXT_SQUASH_VERSION}/vspackage | \
      bsdtar -xvf - extension && \
      mv ./extension /root/.local/share/code-server/extensions/ilevine.squash-${EXT_SQUASH_VERSION} && \
      cd /root/.local/share/code-server/extensions/ilevine.squash-${EXT_SQUASH_VERSION} && \
      npm i

 RUN curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/wholroyd/vsextensions/HCL/${EXT_HCL_VERSION}/vspackage | \
      bsdtar -xvf - extension && \
      mv ./extension /root/.local/share/code-server/extensions/wholroyd.HCL-${EXT_HCL_VERSION} && \
      cd /root/.local/share/code-server/extensions/wholroyd.HCL-${EXT_HCL_VERSION} && \
      npm i

 RUN curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/redhat/vsextensions/vscode-yaml/${EXT_YAML_VERSION}/vspackage | \
      bsdtar -xvf - extension && \
      mv ./extension /root/.local/share/code-server/extensions/redhat.vscode-yaml-${EXT_YAML_VERSION} && \
      cd /root/.local/share/code-server/extensions/redhat.vscode-yaml-${EXT_YAML_VERSION} && \
      npm i

 RUN curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/arcticicestudio/vsextensions/nord-visual-studio-code/${EXT_NORD_VERSION}/vspackage | \
       bsdtar -xvf - extension && \
       mv ./extension /root/.local/share/code-server/extensions/arcticicestudio.nord-visual-studio-code-${EXT_NORD_VERSION} && \
       cd /root/.local/share/code-server/extensions/arcticicestudio.nord-visual-studio-code-${EXT_NORD_VERSION} && \
       npm i


FROM shipyardrun/tools:latest

# Make the default user admin
USER root

ENV GOPATH="/home/coder/go"
ENV PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
ENV GO111MODULE="on"
ENV SHELL=/bin/bash
ENV GO_VERSION=1.13.8

# Add Go and GCC
RUN apt-get update && apt-get install -y git curl gcc && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Go and packages for VSCode
RUN curl -sL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go${GO_VERSION}.tar.gz && \
    tar -C /usr/local -xzf /tmp/go${GO_VERSION}.tar.gz && \
    rm /tmp/go${GO_VERSION}.tar.gz && \
    go get -u github.com/mdempsky/gocode && \
    go get -u github.com/ramya-rao-a/go-outline && \
    go get -u github.com/acroca/go-symbols && \
    go get -u golang.org/x/tools/cmd/guru && \ 
    go get -u golang.org/x/tools/cmd/gorename && \
    go get -u github.com/cweill/gotests/... && \
    go get -u github.com/fatih/gomodifytags && \
    go get -u github.com/josharian/impl && \
    go get -u github.com/davidrjenni/reftools/cmd/fillstruct && \
    go get -u github.com/haya14busa/goplay/cmd/goplay && \
    go get -u github.com/godoctor/godoctor && \
    go get -u github.com/go-delve/delve/cmd/dlv && \
    go get -u github.com/stamblerre/gocode && \
    go get -u github.com/rogpeppe/godef && \
    go get -u golang.org/x/tools/cmd/goimports && \
    go get -u golang.org/x/lint/golint && \
    go get -u golang.org/x/tools/gopls && \
    go get -u github.com/uudashr/gopkgs/v2/cmd/gopkgs

# Add Code server
COPY --from=codercom /usr/local/bin/code-server /usr/local/bin/code-server

COPY --from=node /root/.local/share/code-server/extensions /root/.local/share/code-server/extensions

EXPOSE 8080
CMD ["code-server", "--allow-http", "--auth=none"]