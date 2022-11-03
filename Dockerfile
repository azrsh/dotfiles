FROM ubuntu:latest@sha256:817cfe4672284dcbfee885b1a66094fd907630d610cab329114d036716be49ba

RUN apt-get update
RUN apt-get install -y stow

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
