FROM ubuntu:latest@sha256:d21429c4635332e96a4baae3169e3f02ac8e24e6ae3d89a86002d49a1259a4f7

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
