FROM ubuntu:latest@sha256:c920ba4cfca05503764b785c16b76d43c83a6df8d1ab107e7e6610000d94315c

RUN apt-get update && \
  apt-get install -y sudo curl vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
