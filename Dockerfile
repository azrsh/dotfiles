FROM ubuntu:latest@sha256:aa772c98400ef833586d1d517d3e8de670f7e712bf581ce6053165081773259d

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
