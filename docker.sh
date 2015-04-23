#!/usr/bin/env bash
ARGS=${@:-up}
DOCKER_HOST=tcp://localhost:4243 docker-compose $ARGS
