#!/usr/bin/bash

cd ..

docker build -t localhost/images/base -f docker-images/base.Dockerfile .
docker build -t localhost/images/dev-env -f docker-images/dev-env.Dockerfile .
#docker build -t localhost/images/code-server -f docker-images/code-server.Dockerfile .
