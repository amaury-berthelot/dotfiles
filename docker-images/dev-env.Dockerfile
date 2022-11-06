FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "Europe/Paris" > /etc/timezone

RUN apt update && apt upgrade -y
RUN apt install -y \
  gcc \
  zsh \
  fzf \
  git \
  ripgrep \
  tmux \
  universal-ctags \
  wget \
  curl

RUN useradd -m -s /bin/zsh -d /home/dev dev
RUN chown -R dev /home/dev

WORKDIR /home/dev
USER dev
