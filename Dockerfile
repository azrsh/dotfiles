FROM ubuntu:latest@sha256:dda6886d8d153a2d86f046c9335123c6151d83fd63e446b752ed8d9da261205d

RUN apt-get update
RUN apt-get install -y stow

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
