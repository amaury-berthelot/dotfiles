FROM localhost/images/base

RUN useradd -m -s /bin/zsh -d /home/dev dev

ADD . /home/dev/configs
RUN ln -s /home/dev/configs /home/dev/.dotfiles

RUN chown -R dev /home/dev

WORKDIR /home/dev
USER dev

RUN ./configs/init.sh
RUN ./configs/setup.sh

USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y \
  php8.1 \
  php-sqlite3
USER dev
