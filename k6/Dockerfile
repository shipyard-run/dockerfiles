FROM alpine:latest

ARG TARGETARCH

RUN wget https://github.com/grafana/k6/releases/download/v0.35.0/k6-v0.35.0-linux-${TARGETARCH}.tar.gz -O k6.tar.gz && \
    tar -xzf k6.tar.gz && \
    mv k6-v0.35.0-linux-${TARGETARCH}/k6 /usr/bin/ && \
    rm -rf k6-v0.35.0-linux-${TARGETARCH} && \
    rm k6.tar.gz && \
    chmod +x /usr/bin/k6

USER 12345
WORKDIR /home/k6
ENTRYPOINT ["k6"]