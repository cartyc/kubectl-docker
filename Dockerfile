FROM ubuntu:xenial-20191212 as compile

RUN apt update && apt install -y curl wget && \
    ## Install Kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    ## Install conftest
    wget https://github.com/instrumenta/conftest/releases/download/v0.15.0/conftest_0.15.0_Linux_x86_64.tar.gz && \
    tar xzf conftest_0.15.0_Linux_x86_64.tar.gz && \
    ## Install Kubeval
    wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz && \
    tar xzf kubeval-linux-amd64.tar.gz && \
    ## Install Kustomize
    wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.5.4/kustomize_v3.5.4_linux_amd64.tar.gz && \
    tar xzf kustomize_v3.5.4_linux_amd64.tar.gz

FROM ubuntu:xenial-20191212 as runtime

RUN addgroup --gid 10001 app && \
    adduser --gid 10001 -uid 10001 \
    --disabled-login --home /app --shell /sbin/nologin app

COPY --from=compile /kubectl /usr/local/bin/kubectl
COPY --from=compile /kubeval /usr/local/bin/kubeval
COPY --from=compile /conftest /usr/local/bin/conftest
COPY --from=compile /kustomize /usr/local/bin/kustomize

USER app

CMD [ "kubectl" ]
ENTRYPOINT [""]
