FROM ubuntu:22.04

# no prompt during install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
  zsh \
  fzf \
  git \
  neovim \
  ripgrep \
  tmux \
  universal-ctags \
  wget

RUN useradd -m -s /bin/zsh dev

COPY . /home/dev/configs
RUN chown -R dev /home/dev

RUN su dev -c "mkdir /home/dev/.config"
RUN su dev -c "cd /home/dev/configs && ./init.sh && ./setup.sh"

# small hack for colors to work with neovim in tmux
RUN su dev -c "echo TERM=screen-256color >> /home/dev/.bashrc"

CMD ["sh"]
