FROM ubuntu

WORKDIR /root

COPY ./root /root

RUN bash -c 'source .bashrc' \
    && sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list \
    && apt-get -y update && apt-get -y upgrade \
    && apt-get -y install xcb openjdk-11-jdk-headless unzip vim gdb wget git python python-pip python-dev python3-dev python3-pip libffi-dev build-essential libssh-dev python3-venv cmake \
    && wget https://github.com/radareorg/cutter/releases/download/v1.8.2/Cutter-v1.8.2-x64.Linux.AppImage -O cutter \
    && chmod +x cutter && mv cutter /root/bin \
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
    && wget https://github.com/hugsy/gef/raw/master/gef.py -O ~/.gdbinit-gef.py \
    && wget https://ghidra-sre.org/ghidra_9.0.4_PUBLIC_20190516.zip -O /root/ghidra.zip \
    && unzip /root/ghidra.zip -d /root && mv /root/ghidra_9.0.4 /root/ghidra && mv /root/ghidra /root/bin && rm /root/ghidra* \
    && git clone https://github.com/longld/peda.git /root/peda \
    && apt-get autoremove && apt-get clean

ENV LANG C.UTF-8

ENV LC_ALL C.UTF-8
