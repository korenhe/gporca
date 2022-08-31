#Download base image ubuntu 22.04

FROM ubuntu:22.04 As builder

# Disable prompts on Ubuntu
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y -q install cmake g++-11 \
    git curl wget autoconf ninja-build cmake-curses-gui \
    flex bison \
    gosu sudo \
    binutils-dev libunwind-dev libfmt-dev \
    clang-14 clangd-14 libczmq-dev libtool-bin && \
    rm -rf /var/lib/apt/lists/*


FROM builder As dev

RUN git clone https://github.com/greenplum-db/gp-xerces.git /gp-xerces-src
RUN mkdir -p /build/gp-xerces && cd /build/gp-xerces && CXX=g++-11 /gp-xerces-src/configure --prefix=/build/gp-xerces/install && \
    make && make install

RUN mkdir /workspace
WORKDIR /workspace

COPY docker/entrypoint.sh /workspace/entrypoint.sh
RUN chmod +x /workspace/entrypoint.sh

ENTRYPOINT ["/workspace/entrypoint.sh"]
