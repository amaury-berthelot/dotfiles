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
  curl \
  python3 \
  xclip
