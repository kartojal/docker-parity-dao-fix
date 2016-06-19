FROM ubuntu:14.04
MAINTAINER David Canillas

RUN apt-get update && \
    apt-get install -y \
    g++ \
    curl \
    git 

# Clone ethcote/parity with the softforktrigger branch
RUN git clone -b softforktrigger https://github.com/ethcore/parity.git /root/parity

# Install rust silently 
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Export rust binaries to $PATH
ENV PATH /root/.cargo/bin:$PATH

# Export rust LIBRARY_PATH
ENV LIBRARY_PATH /usr/local/lib

# Show backtraces
ENV RUST_BACKTRACE 1

# Build parity
WORKDIR /root/parity
RUN cargo build --release

WORKDIR /root/parity/target/release
ENTRYPOINT ["./parity"]
