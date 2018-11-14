# Rust
# A Docker image for Rust environment
# 

FROM debian:jessie-20180831

# toolchain choice
# 1.xx.x, stable or nightly ...
ARG RUST_VER=1.29.0

LABEL name="rust" \
      version="1" \
      rust_version="${RUST_VER}" \
      author="eldesh <nephits@gmail.com>"

ENV OS_VERSION=jessie-20180831
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
      sudo \
      curl \
      ca-certificates \
      git \
      openssh-client \
      gcc \
      libc6-dev \
      pkg-config \
 # setup the user *rust:rust(1000:1000)*
 && groupadd --gid 1000 rust \
 && useradd --create-home --shell /bin/bash \
      --groups sudo --uid 1000 --gid 1000 rust \
 && echo "rust:rust" | chpasswd \
 && echo 'rust ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/rust \
 # install rust
 && curl https://sh.rustup.rs -sSf | sudo -H -g rust -u rust sh -s -- -y --default-toolchain ${RUST_VER} \
 && sudo -H -g rust -u rust -i rustup component add rustfmt-preview \
 && sudo -H -g rust -u rust -i mkdir source \
 # cleanup
 && apt-get remove -y \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists \
 && rm -rf /var/cache/apt/archives

# switch user to rust
USER rust
WORKDIR /home/rust/source
ENV HOME /home/rust
ENV PATH $PATH:$HOME/.cargo/bin

CMD ["bash"]

