FROM alpine:latest

# Versions to install
ENV SHIPYARD_VERSION=0.2.15

RUN apk add --update bash supervisor curl docker iptables ip6tables git

# Force storage driver to use vfs
RUN mkdir -p /etc/docker
RUN echo "{ \ 
    \"storage-driver\": \"vfs\" \
    }" > /etc/docker/daemon.json

# Install the CNI Plugins
RUN wget https://github.com/shipyard-run/shipyard/releases/download/v${SHIPYARD_VERSION}/shipyard_${SHIPYARD_VERSION}_Linux_x86_64.tar.gz -O /tmp/shipyard.tar.gz && \
    tar -C /usr/bin -xzf /tmp/shipyard.tar.gz

# Setup bash and supervisord etc
RUN sed -i 's/\/bin\/ash/\/bin\/bash/g' /etc/passwd

# Setup the supervisor d file
RUN mkdir -p /etc/supervisor.d/
COPY supervisor.ini /etc/supervisor.d/supervisor.ini

COPY start_shipyard.sh /start_shipyard.sh
RUN chmod +x ./start_shipyard.sh

# Run supervisord
#RUN sed -i 's/;nodaemon=false/nodaemon=true/g' /etc/supervisord.conf

ENTRYPOINT ["/start_shipyard.sh"]