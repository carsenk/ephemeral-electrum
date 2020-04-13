FROM python:3.7-slim-buster

ARG ELECTRUM_VERSION=3.3.8
ENV ELECTRUM_INSTALL_DIR /opt/electrum

RUN mkdir $ELECTRUM_INSTALL_DIR
WORKDIR $ELECTRUM_INSTALL_DIR

RUN apt-get update
RUN apt-get install -y git
RUN git clone git://github.com/spesmilo/electrum.git $ELECTRUM_INSTALL_DIR 
RUN git checkout $ELECTRUM_VERSION
RUN git submodule update --init
RUN apt-get install -y libsecp256k1-0
RUN python3 -m pip install --user . cryptography
RUN ln -s $ELECTRUM_INSTALL_DIR/run_electrum /usr/local/bin/electrum

WORKDIR /root

COPY entrypoint /usr/local/bin/
ENTRYPOINT ["entrypoint"]
