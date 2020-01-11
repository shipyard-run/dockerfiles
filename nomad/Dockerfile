FROM envoyproxy/envoy-alpine:v1.12.2

# Fetch Consul
RUN apk add -u bash curl && \
    wget https://releases.hashicorp.com/consul/1.6.2/consul_1.6.2_linux_amd64.zip -O /tmp/consul.zip && \
    unzip /tmp/consul.zip -d /tmp && \
    mv /tmp/consul /usr/local/bin/consul

# Fetch the nomad binary
RUN apk add -u bash curl && \
    wget https://releases.hashicorp.com/nomad/0.10.2/nomad_0.10.2_linux_amd64.zip -O /tmp/nomad.zip && \
    unzip /tmp/nomad.zip -d /tmp && \
    mv /tmp/nomad /usr/local/bin/nomad

# Add the nomad config
COPY ./nomad_server.hcl /etc/nomad.d/config.hcl

# Setup bash and supervisord etc
RUN apk add --update bash supervisor curl vim jq 
RUN sed -i 's/\/bin\/ash/\/bin\/bash/g' /etc/passwd

# Setup the supervisor d file
RUN mkdir -p /etc/supervisor.d/
COPY supervisor.ini /etc/supervisor.d/supervisor.ini

# Run supervisord
RUN sed -i 's/;nodaemon=false/nodaemon=true/g' /etc/supervisord.conf

# set default env vars so supervisor
# does not crash on start
ENV CONSUL_SERVER=localhost
ENV CONSUL_DATACENTER=dc1

# Docker
RUN apk add -u docker

# add default config folder
RUN mkdir /config

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisord.conf"]