FROM envoyproxy/envoy-alpine:v1.11.2

# Versions to install
ENV CONSUL_VERION=1.8.9
ENV NOMAD_VERSION=0.11.8
ENV CNI_PLUGINS=0.8.6

# set default env vars so supervisor
# does not crash on start
ENV CONSUL_SERVER=localhost
ENV CONSUL_DATACENTER=dc1

RUN apk add --update bash supervisor curl docker iptables ip6tables

# Force storage driver to use vfs
RUN mkdir -p /etc/docker
RUN echo "{ \ 
    \"storage-driver\": \"vfs\" \
    }" > /etc/docker/daemon.json

# Fetch Consul
RUN wget https://releases.hashicorp.com/consul/${CONSUL_VERION}/consul_${CONSUL_VERION}_linux_amd64.zip -O /tmp/consul.zip && \
    unzip /tmp/consul.zip -d /tmp && \
    mv /tmp/consul /usr/local/bin/consul

# Fetch the nomad binary
RUN wget https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -O /tmp/nomad.zip && \
    unzip /tmp/nomad.zip -d /tmp && \
    mv /tmp/nomad /usr/local/bin/nomad

# Install the CNI Plugins
RUN wget https://github.com/containernetworking/plugins/releases/download/v${CNI_PLUGINS}/cni-plugins-linux-amd64-v${CNI_PLUGINS}.tgz -O /tmp/cni.tgz && \
    mkdir -p /opt/cni/bin && \
    tar -C /opt/cni/bin -xzf /tmp/cni.tgz

# Add the nomad config
COPY ./nomad_server.hcl /etc/nomad.d/config.hcl
COPY ./start_nomad.sh /etc/nomad.d/start_nomad.sh
RUN chmod +x /etc/nomad.d/start_nomad.sh

# Setup bash and supervisord etc
RUN sed -i 's/\/bin\/ash/\/bin\/bash/g' /etc/passwd

# Setup the supervisor d file
RUN mkdir -p /etc/supervisor.d/
COPY supervisor.ini /etc/supervisor.d/supervisor.ini

# Run supervisord
RUN sed -i 's/;nodaemon=false/nodaemon=true/g' /etc/supervisord.conf


# add default config folder
RUN mkdir /config

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisord.conf"]
