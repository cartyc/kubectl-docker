FROM ubuntu:xenial-20191212

RUN apt update && apt install -y curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

ENTRYPOINT [ "kubectl" ]