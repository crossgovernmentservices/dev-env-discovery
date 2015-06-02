#!/usr/bin/env bash

echo "password is: prototypes"
export HASH=$(sudo docker ps -a|grep "devenv_db"|cut -f1 -d' ')
psql -h $(sudo docker inspect $HASH | jq -r '.[].NetworkSettings.IPAddress') prototypes -p 5432 -U prototypes
