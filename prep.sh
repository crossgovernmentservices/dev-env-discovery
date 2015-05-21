#!/usr/bin/env bash

rm -rf docker-compose.yml
cp docker-compose-template.yml docker-compose.yml
while read CONF_ITEM; do
  export CONF_ITEM_KEY=$(echo $CONF_ITEM | cut -f1 -d':')
  export CONF_ITEM_VALUE=$(echo $CONF_ITEM | cut -f2 -d':')
  perl -pi -e 's#%$ENV{CONF_ITEM_KEY}%#$ENV{CONF_ITEM_VALUE}#g' docker-compose.yml
done < ~/.xgsenv
