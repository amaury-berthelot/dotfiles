FROM localhost/images/dev-env

# install code-server
RUN curl -fOL https://github.com/coder/code-server/releases/download/v4.5.0/code-server_4.5.0_amd64.deb
RUN dpkg -i code-server_4.5.0_amd64.deb
RUN rm code-server_4.5.0_amd64.deb

USER dev

CMD ["code-server", "--auth=none", "--bind-addr=0.0.0.0:8080"]
