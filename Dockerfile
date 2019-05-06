FROM golang:1.12.4 AS builder

# Install base packages
RUN apt-get update && apt-get -y install \
    curl \
    dnsutils \
    git \
    jq \
    unzip \
    wget && \
    rm -rf /var/lib/apt/lists/*

ENV CF_CLI_VERSION "6.41.0"

RUN set -e; \
    curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&version=${CF_CLI_VERSION}" | tar -zx -C /usr/local/bin;
