FROM ubuntu:latest

COPY ./ /root/dotfiles/
WORKDIR /root/dotfiles/
RUN apt-get update
RUN apt-get install make -y
RUN make
