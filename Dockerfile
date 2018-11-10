FROM ubuntu:16.04

ENV NODE_V=v8.1.0
ENV PATH=/usr/local/node-${NODE_V}-linux-x64/bin:$PATH

RUN apt-get update
RUN apt-get install -y \
  curl \
  openjdk-8-jdk

RUN apt-get clean && apt-get install -y \
    x11vnc \
    xvfb \
    fluxbox \
    wmctrl \
    wget \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get -y install google-chrome-stable \
    && wget https://nodejs.org/download/release/${NODE_V}/node-${NODE_V}-linux-x64.tar.gz && \
        tar -zxvf node-${NODE_V}-linux-x64.tar.gz -C /usr/local

# Install Goss
RUN curl -fsSL https://goss.rocks/install | sh

RUN useradd test \
    && mkdir -p /home/test \
    && chown -v -R test:test /home/test

RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

COPY bootstrap.sh /

CMD '/bootstrap.sh'