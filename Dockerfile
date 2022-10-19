FROM ubuntu:latest@sha256:a8fe6fd30333dc60fc5306982a7c51385c2091af1e0ee887166b40a905691fd0

RUN apt-get update
RUN apt-get install -y stow

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
