#!/bin/bash

cp -f /app/config/mumble-server-template.ini /app/config/mumble-server.ini
sed -i -e "s|{{MUMBLE_WELCOME_TEXT}}|${MUMBLE_WELCOME_TEXT}|g" /app/config/mumble-server.ini
sed -i -e "s|{{MUMBLE_PORT}}|${MUMBLE_PORT}|g" /app/config/mumble-server.ini
sed -i -e "s|{{MUMBLE_HOST}}|${MUMBLE_HOST}|g" /app/config/mumble-server.ini
sed -i -e "s|{{MUMBLE_PASSWORD}}|${MUMBLE_PASSWORD}|g" /app/config/mumble-server.ini
sed -i -e "s|{{MUMBLE_BANDWIDTH}}|${MUMBLE_BANDWIDTH}|g" /app/config/mumble-server.ini
sed -i -e "s|{{MUMBLE_USERS}}|${MUMBLE_USERS}|g" /app/config/mumble-server.ini

/usr/sbin/murmurd -fg -ini "/app/config/mumble-server.ini"
