FROM ubuntu:latest@sha256:83f0c2a8d6f266d687d55b5cb1cb2201148eb7ac449e4202d9646b9083f1cee0

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
