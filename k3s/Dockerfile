ARG K8S_VERSION=v1.22.2

FROM rancher/k3s:${K8S_VERSION}-k3s1 as base

COPY ./start-k3s.sh /start-k3s.sh
RUN chmod +x ./start-k3s.sh

ENV PATH="$PATH:/bin/aux"
ENV CRI_CONFIG_FILE="/var/lib/rancher/k3s/agent/etc/crictl.yaml"

ENTRYPOINT ["/start-k3s.sh"]
