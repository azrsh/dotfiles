FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y stow

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup_local.sh
