FROM ubuntu

WORKDIR /root

COPY ./root /root

RUN bash -c 'source .bashrc' \
    && apt-get -y update && apt-get -y upgrade \
    && apt-get -y install unzip vim gdb wget git python python-pip python-dev python3-dev python3-pip libffi-dev build-essential libssh-dev python3-venv cmake \
    && pip3 install capstone ropper unicorn \
    && pip install pwntools \
    && cd /root && python3 -m venv angr \
    && bash -c 'source /root/angr/bin/activate && pip install --upgrade pip && pip install angr && deactivate' \
    && git clone https://github.com/keystone-engine/keystone.git \
    && cd keystone/bindings/python \
    && make install3 \
    && cd ../.. \
    && mkdir build \
    && cd build \
    && ../make-share.sh \
    && make install \
    && ldconfig \
    && wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh \
    && wget https://ghidra-sre.org/ghidra_9.0.4_PUBLIC_20190516.zip -O ghidra.zip \
    && unzip ghidra.zip -d /root/bin && rm ghidra.zip \
    && apt-get autoremove && apt-get clean

CMD bash
