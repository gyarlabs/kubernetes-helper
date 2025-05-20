FROM debian:bullseye-slim

LABEL maintainer="egyardian99@gmail.com"
LABEL purpose="k8s-debug"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash curl wget dnsutils iputils-ping net-tools iproute2 \
    tcpdump netcat procps vim nano lsof strace jq file tar unzip ca-certificates && \
    curl -LO https://github.com/k8sgpt-ai/k8sgpt/releases/download/v0.4.15/k8sgpt_Linux_x86_64.tar.gz && \
    tar -xzvf k8sgpt_Linux_x86_64.tar.gz && \
    mv k8sgpt /usr/local/bin/k8sgpt && \
    chmod +x /usr/local/bin/k8sgpt && \
    rm -f k8sgpt_Linux_x86_64.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
