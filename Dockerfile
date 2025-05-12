FROM ubuntu:24.04

#
# Use apt mirror to tsinghua mirror
#
RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get update && apt-get install -y \
    gcc-arm-linux-gnueabi \
    build-essential \
    device-tree-compiler \
    bc \
    libssl-dev \
    libncurses5-dev \
    flex \
    bison \
    libelf-dev \
    wget \
    git \
    vim \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash fanke && \
    echo "fanke:fanke" | chpasswd && \
    usermod -aG sudo fanke && \
    echo "fanke ALL=(ALL) ALL" > /etc/sudoers.d/fanke

COPY simple_start.sh /bin/
RUN chmod +x /bin/simple_start.sh

USER root

ENTRYPOINT ["/bin/simple_start.sh"]  
