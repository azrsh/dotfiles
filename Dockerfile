FROM ubuntu:latest@sha256:eecba05a9ccbc219cb0f0dd280034c6ee1aab0b00b458e680f9c4efc6ca3feda

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
