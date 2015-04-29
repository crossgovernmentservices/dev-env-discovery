#!/usr/bin/env bash
ARGS=${@:-up}

function run_linux() {
  DOCKER_HOST=tcp://localhost:4243 docker-compose $ARGS
}

function run_mac() {
  eval "$(boot2docker shellinit)"
  docker-compose $ARGS
}

function run_nop() {
  echo "This script doesn't support $OSTYPE"
}

case "$OSTYPE" in
  linux*)   run_linux ;;
  darwin*)  run_mac   ;; 
  msys*)    run_nop   ;;
  solaris*) run_nop   ;;
  bsd*)     run_nop   ;;
  *)        run_nop   ;;
esac

