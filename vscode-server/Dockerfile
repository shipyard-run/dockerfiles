FROM ubuntu

RUN apt update && apt upgrade -y && apt install -y wget curl zip git

RUN wget -O- https://aka.ms/install-vscode-server/setup.sh | sh

RUN code-server serve-local --accept-server-license-terms --install-extension vscodevim.vim

ENTRYPOINT ["code-server", "serve-local","--accept-server-license-terms","--without-connection-token","--host","0.0.0.0","--verbose"]
