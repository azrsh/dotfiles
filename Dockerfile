FROM ubuntu:latest@sha256:5d070ad5f7fe63623cbb99b4fc0fd997f5591303d4b03ccce50f403957d0ddc4

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
