cp -f /etc/mumble/mumble-server-template.ini /etc/mumble/mumble-server.ini
sed -i -e 's/{{MUMBLE_WELCOME_TEXT}}/${MUMBLE_WELCOME_TEXT}/g' /etc/mumble/mumble-server.ini
sed -i -e 's/{{MUMBLE_PORT}}/${MUMBLE_PORT}/g' /etc/mumble/mumble-server.ini
sed -i -e 's/{{MUMBLE_HOST}}/${MUMBLE_HOST}/g' /etc/mumble/mumble-server.ini
sed -i -e 's/{{MUMBLE_PASSWORD}}/${MUMBLE_PASSWORD}/g' /etc/mumble/mumble-server.ini
sed -i -e 's/{{MUMBLE_BANDWIDTH}}/${MUMBLE_BANDWIDTH}/g' /etc/mumble/mumble-server.ini
sed -i -e 's/{{MUMBLE_USERS}}/${MUMBLE_USERS}/g' /etc/mumble/mumble-server.ini

/usr/sbin/murmurd -fg -ini "/etc/mumble/mumble-server.ini"