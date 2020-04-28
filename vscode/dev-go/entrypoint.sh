#!/bin/bash -e

EXT_SQUASH_VERSION=0.5.18
EXT_HCL_VERSION=0.0.5
EXT_YAML_VERSION=0.7.2
EXT_NORD_VERSION=0.12.0
EXT_GO_VERSION=0.13.1

# Copy the extension cache if not present
if [ ! -d "/root/.local/share/code-server/extensions/arcticicestudio.nord-visual-studio-code-${EXT_NORD_VERSION}" ]; then
  cp -R /extensions-cache/arcticicestudio.nord-visual-studio-code-${EXT_NORD_VERSION} \
        /root/.local/share/code-server/extensions/arcticicestudio.nord-visual-studio-code-${EXT_NORD_VERSION}
fi

if [ ! -d "/root/.local/share/code-server/extensions/ms-vscode.go-${EXT_GO_VERSION}" ]; then
 cp -R /extensions-cache/ms-vscode.go-${EXT_GO_VERSION} \
       /root/.local/share/code-server/extensions/ms-vscode.go-${EXT_GO_VERSION}
fi

if [ ! -d "/root/.local/share/code-server/extensions/redhat.vscode-yaml-${EXT_YAML_VERSION}" ]; then
cp -R /extensions-cache/redhat.vscode-yaml-${EXT_YAML_VERSION} \
      /root/.local/share/code-server/extensions/redhat.vscode-yaml-${EXT_YAML_VERSION}
fi

if [ ! -d "/root/.local/share/code-server/extensions/wholroyd.HCL-${EXT_HCL_VERSION}" ]; then
cp -R /extensions-cache/wholroyd.HCL-${EXT_HCL_VERSION} \
      /root/.local/share/code-server/extensions/wholroyd.HCL-${EXT_HCL_VERSION}
fi

dumb-init fixuid -q /usr/local/bin/code-server --auth none --host 0.0.0.0 .