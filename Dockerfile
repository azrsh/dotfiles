FROM ubuntu:latest@sha256:c098726dd9b9733f3e885f8de0ef375206a311b0a317eadc40d347b1115fb944

RUN apt-get update && \
  apt-get install -y sudo curl vim

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN bash setup.sh
