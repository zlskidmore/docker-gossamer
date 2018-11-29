# work from LTS ubuntu
FROM ubuntu:18.04

# set the environment variables
ENV goassamer_version 1.0.0

RUN apt-get update && apt-get install -y \
  bzip2 \
  g++ \
  make \
  ncurses-dev \
  wget \
  zlib1g-dev \
  cmake \
  libboost-all-dev \
  pandoc \
  zlib1g-dev \
  libbz2-dev \
  libsqlite3-dev \
  unzip

RUN apt-get install -y --no-install-recommends libnss-sss

ENV GOSSAMER_INSTALL_DIR=/tmp/gossamer-master/build/

WORKDIR /tmp
RUN wget https://github.com/data61/gossamer/archive/master.zip
RUN unzip master.zip

WORKDIR /tmp/gossamer-master
RUN mkdir build

WORKDIR /tmp/gossamer-master/build
RUN cmake ..
RUN make
RUN make test
RUN make install

RUN ln -s $GOSSAMER_INSTALL_DIR/src/xenome /usr/bin/xenome
RUN ln -s $GOSSAMER_INSTALL_DIR/src/gossple /usr/bin/gossple
RUN ln -s $GOSSAMER_INSTALL_DIR/src/goss /usr/bin/goss
RUN ln -s $GOSSAMER_INSTALL_DIR/src/electus /usr/bin/electus
