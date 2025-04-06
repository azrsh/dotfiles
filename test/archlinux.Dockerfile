FROM archlinux:latest

RUN pacman -Syu --noconfirm sudo

RUN groupadd -g 1000 dotfiles && \
  useradd -m -s /bin/bash -u 1000 -g 1000 dotfiles && \
  echo 'dotfiles ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER dotfiles
WORKDIR /home/dotfiles
