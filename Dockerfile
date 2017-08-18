FROM ubuntu:16.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget gcc make

RUN wget https://cloud.github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz \
 && tar zxvf libevent-2.0.19-stable.tar.gz \
 && cd libevent-2.0.19-stable \
 && ./configure --prefix=/usr/ \
 && make && make install

COPY magent /

RUN mkdir /usr/lib64/
RUN ln -svf /usr/lib/libevent* /usr/lib64/
RUN cp /lib/x86_64-linux-gnu/libm.so.6 /usr/lib64/libm.a

WORKDIR /magent
RUN make

RUN cp /magent/magent /bin/