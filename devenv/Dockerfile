FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "Europe/Paris" > /etc/timezone

RUN apt update && apt upgrade -y
RUN apt install -y \
  gcc \
  zsh \
  fzf \
  jq \
  git \
  ripgrep \
  tmux \
  universal-ctags \
  wget \
  curl \
  python3 \
  xclip

RUN echo "deb http://security.ubuntu.com/ubuntu focal-security main" | tee /etc/apt/sources.list.d/focal-security.list # for libssl1.1
RUN apt update
RUN apt install -y \
  docker.io \
  docker-compose \
  sudo \
  libssl1.1 # at least for mongo-in-memory

# install VSCodium
RUN curl -o /tmp/vscodium.deb -L https://github.com/VSCodium/vscodium/releases/download/1.78.2.23132/codium_1.78.2.23132_amd64.deb
RUN apt install -y /tmp/vscodium.deb
RUN rm /tmp/vscodium.deb

RUN useradd -m -s /bin/zsh -d /home/dev -p "$1$k4WVNBSF$c6iagkQbXHQnIHgNU6A381" dev
WORKDIR /home/dev

RUN usermod -aG docker dev

RUN git clone https://github.com/amaury-berthelot/dotfiles.git configs
RUN ln -s /home/dev/configs /home/dev/.dotfiles
RUN chown -R dev /home/dev

# TODO: move these apt install up (added there for now to avoid a full rebuild)
RUN apt install -y openjdk-19-jre
RUN apt update
RUN apt install -y meld

USER dev
RUN ./configs/init.sh
RUN ./configs/setup.sh

ENV JAVA_HOME=/usr/lib/jvm/java-19-openjdk-amd64
