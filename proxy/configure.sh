#!/usr/bin/env bash
# Assumptions:
# one instance per server

echo "Running configuration..."

TMPCONF=$(mktemp -t "proxy.XXXXXX")
cp nginx.conf $TMPCONF

# Get the linked app names.
# Assumes names without _ in them.
function apps {
    DEFAULT_HOST=$(printenv|grep DEFAULT_HOST| cut -d'=' -f2)
    IFS=' '
    APPS=($TUTUM_HACK)
    #APPS=($(cat /etc/hosts | egrep -v "::|127.0.0.1|_" | cut -d$'\t' -f2))
    for APP in "${APPS[@]}"; do
        echo "Configuring app: $APP"
        # get IP:PORT from env vars using app names
        # ignore docker-compose prefixes, e.g. XGS_
        IP_PORT=$(printenv | grep -i "${APP}_PORT" | egrep -v "XGS_" | grep "_TCP=" | cut -d'/' -f3)
        if [ -z $IP_PORT ]; then
            continue
        fi
        VHOST=$(printenv | grep -i "${APP}_ENV_VIRTUAL_HOST" | cut -d'=' -f2)
        cat <<EOF >> $TMPCONF

# $APP
upstream $VHOST {
  server $IP_PORT ;
}
server {
EOF
        if [ "$DEFAULT_HOST" == "$VHOST" ] ; then
            cat <<EOF >> $TMPCONF
  listen 80 default_server;
EOF
        fi
        cat <<EOF >> $TMPCONF
  server_name $VHOST;
  location / {
    proxy_pass http://$VHOST ;
  }
}
EOF
    done
    #echo "}" >> $TMPCONF
}

apps
echo "Writing config..."
#cp $TMPCONF /etc/nginx/nginx.conf
cp $TMPCONF /etc/nginx/conf.d/default.conf
rm $TMPCONF
echo "Done."
