FROM ubuntu:latest@sha256:74f92a6b3589aa5cac6028719aaac83de4037bad4371ae79ba362834389035aa

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
