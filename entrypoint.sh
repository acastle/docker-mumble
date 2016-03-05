#!/bin/bash

CONFIG="/app/config/mumble-server.ini"
CERT="/app/certs/mumble.pem"
CERT_KEY="/app/certs/mumble.pem"

if [ ! -f $CONFIG ]; then
  echo "Making mumble-server.ini"
  cp -f /app/config/mumble-server-template.ini $CONFIG
  sed -i -e "s|{{MUMBLE_WELCOME_TEXT}}|${MUMBLE_WELCOME_TEXT}|g" $CONFIG
  sed -i -e "s|{{MUMBLE_PASSWORD}}|${MUMBLE_PASSWORD}|g" $CONFIG
  sed -i -e "s|{{MUMBLE_BANDWIDTH}}|${MUMBLE_BANDWIDTH}|g" $CONFIG
  sed -i -e "s|{{MUMBLE_USERS}}|${MUMBLE_USERS}|g" $CONFIG
fi

if [[ ! (-f "$CERT" && -f "$CERT_KEY" ) ]]; then
  echo "Creating mumble.key and mumble_concat.csr"
  openssl req -x509 -nodes -newkey rsa:4096 -keyout /app/certs/mumble.key -out /app/certs/mumble.pem -subj "/CN=${MUMBLE_HOST}" -days 3650
fi

/usr/sbin/murmurd -fg -ini "/app/config/mumble-server.ini"