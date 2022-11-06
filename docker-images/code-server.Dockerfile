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

# install code-server
RUN curl -fOL https://github.com/coder/code-server/releases/download/v4.5.0/code-server_4.5.0_amd64.deb
RUN dpkg -i code-server_4.5.0_amd64.deb
RUN rm code-server_4.5.0_amd64.deb

USER dev

CMD ["code-server", "--auth=none", "--bind-addr=0.0.0.0:8080"]
