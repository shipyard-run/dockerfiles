FROM rancher/k3s:v1.18.15-k3s1


ENV PATH="$PATH:/bin/aux"
#ENV CRI_CONFIG_FILE="/var/lib/rancher/k3s/agent/etc/crictl.yaml"
RUN echo "runtime-endpoint: unix:///run/containerd/containerd.sock" > /etc/crictl.yaml

ENTRYPOINT ["/bin/k3s"]
CMD ["agent"]
