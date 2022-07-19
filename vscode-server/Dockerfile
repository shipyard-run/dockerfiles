FROM ubuntu

RUN apt update && apt upgrade -y && apt install -y curl wget zip git && rm -rf /var/lib/apt/lists/*

RUN wget -O- https://aka.ms/install-vscode-server/setup.sh | sh

RUN code-server serve-local --accept-server-license-terms --install-extension vscodevim.vim

ENTRYPOINT ["code-server", "serve-local","--accept-server-license-terms","--without-connection-token","--host","0.0.0.0","--verbose"]
