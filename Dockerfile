FROM ubuntu:16.04
MAINTAINER insp3ct0r_x

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ Asia/Seoul

RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/g" /etc/apt/sources.list
RUN apt update && apt upgrade -y
RUN apt install xinetd gdbserver binutils -y

RUN dpkg --add-architecture i386
RUN apt update
RUN apt install libc6-dbg libc6:i386 libc6-dbg:i386 -y

WORKDIR /root/
COPY chall.bin /root/
RUN chmod 755 /root/chall.bin
COPY chall.daemon /etc/xinetd.d/chall
RUN echo "chall	9929/tcp" >> /etc/services

COPY ep.sh /root/
RUN chmod 755 /root/ep.sh
ENTRYPOINT ["/root/ep.sh"]
