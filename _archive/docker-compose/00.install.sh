#!/bin/bash

DOCKER_VERSION=1.29.0
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
