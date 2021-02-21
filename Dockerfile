FROM ubuntu:latest

RUN apt-get update
RUN apt-get install make -y
RUN apt-get install vim -y
COPY ./ /root/dotfiles/
