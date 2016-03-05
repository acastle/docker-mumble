#!/bin/bash

CONFIG="/app/config/mumble-server.ini"
CERT="/app/certs/mumble_concat.csr"
CERT_KEY="/app/certs/mumble.key"

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
  openssl req -nodes -newkey rsa:4096 -keyout /app/certs/mumble.key -out /app/certs/mumble.csr -subj "/CN=${MUMBLE_HOST}"
  wget -P /app/certs --no-check-certificate https://www.startssl.com/certs/sub.class1.server.ca.pem
  cat /app/certs/sub.class1.server.ca.pem > /app/certs/mumble_concat.crt
  cat /app/certs/mumble.crt >> mumble_concat.crt
fi

/usr/sbin/murmurd -fg -ini "/app/config/mumble-server.ini"