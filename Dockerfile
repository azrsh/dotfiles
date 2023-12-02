FROM ubuntu:latest@sha256:149d67e29f765f4db62aa52161009e99e389544e25a8f43c8c89d4a445a7ca37

RUN apt-get update && \
  apt-get install -y stow tmux vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
