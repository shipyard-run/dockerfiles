FROM rancher/k3s:v1.19.7-k3s1

ENV PATH="$PATH:/bin/aux"
ENV CRI_CONFIG_FILE="/var/lib/rancher/k3s/agent/etc/crictl.yaml"

# We need to start containerd to import the base images
RUN echo "runtime-endpoint: unix:///run/containerd/containerd.sock" > /bin/crictl.yaml && \
  nohup /bin/containerd & \
  sleep 5 && \
  crictl pull shipyardrun/connector:v0.0.16 && \
  crictl pull coredns/coredns:1.6.3 && \
  crictl images ls

ENTRYPOINT ["/bin/k3s"]
CMD ["agent"]
