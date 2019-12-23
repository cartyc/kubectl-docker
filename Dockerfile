FROM ubuntu:xenial-20191212 as compile

RUN apt update && apt install -y curl wget && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    wget https://github.com/instrumenta/conftest/releases/download/v0.15.0/conftest_0.15.0_Linux_x86_64.tar.gz && \
    tar xzf conftest_0.15.0_Linux_x86_64.tar.gz && \
    wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz && \
    tar xf kubeval-linux-amd64.tar.gz && \
    pwd

FROM gcr.io/distroless/base as runtime

COPY --from=compile /kubectl /usr/local/bin/kubectl
COPY --from=compile /kubeval /usr/local/bin/kubeval
COPY --from=compile /conftest /usr/local/bin/conftest


CMD [ "kubectl" ]
ENTRYPOINT []