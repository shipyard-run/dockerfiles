FROM golang:latest

RUN go get github.com/oxequa/realize && \
  cd /go/src/github.com/oxequa/realize && \
  git fetch && \
  git checkout v2.0.2 && \ 
  go get . && \
  go build -o /usr/local/bin/realize .

WORKDIR /files