FROM ubuntu:latest@sha256:81bba8d1dde7fc1883b6e95cd46d6c9f4874374f2b360c8db82620b33f6b5ca1

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
