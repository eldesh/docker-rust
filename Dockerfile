# Rust
# A Docker image for Rust environment
# 

FROM ubuntu:18.04

# toolchain choice
# 1.xx.x, stable or nightly ...
ARG RUST_VER=nightly

LABEL name="rust" \
      version="1" \
      rust_version="${RUST_VER}" \
      author="eldesh <nephits@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
 && apt-get -y install --no-install-recommends \
      sudo \
      curl \
      ca-certificates \
      gcc \
      libc6-dev \
      pkg-config \
      git \
      openssh-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# setup the user *rust:rust(1000:1000)*
RUN groupadd --gid 1000 rust \
 && useradd --create-home --shell /usr/bin/bash \
      --groups sudo --uid 1000 --gid 1000 rust \
 && echo "rust:rust" | chpasswd \
 && echo 'rust ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/rust

# switch user to rust
USER rust
WORKDIR /home/rust/source
ENV HOME=/home/rust
ENV PATH $PATH:$HOME/.cargo/bin

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain ${RUST_VER} \
 && rustup component add rustfmt-preview

CMD ["bash"]

