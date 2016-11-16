# Pistache.io-docker Copyright (C) 2016 Rob Williamson
FROM debian:jessie

MAINTAINER Rob Williamson

WORKDIR /root/build

# Install build dependencies & get the code.
RUN apt-get update
RUN apt-get install -y git
RUN git clone https://github.com/oktal/pistache.git
WORKDIR pistache
RUN git submodule update --init
RUN apt-get install -y g++
RUN apt-get install -y cmake

# Build Pistache.io.
WORKDIR build
RUN cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
RUN make

# Install
RUN make install

# Create a user & folder for subsequent Pistache.io projects.
RUN useradd pistache
WORKDIR /home/pistache
RUN chown pistache:users /home/pistache

# Clean up the build files.
RUN rm -rf /root/build

# Switch to the user.
USER pistache
