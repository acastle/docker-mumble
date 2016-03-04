FROM ubuntu:14.04
MAINTAINER Alex Castle <agcastle64@gmail.com>

ENV MUMBLE_WELCOME_TEXT="<br />Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay!<br />" \
  MUMBLE_PORT=64738 \
  MUMBLE_HOST=0.0.0.0 \
  MUMBLE_PASSWORD="" \
  MUMBLE_BANDWIDTH=72000 \
  MUMBLE_USERS=100

ADD mumble-server.ini /etc/mumble/mumble-server-template.ini
ADD entrypoint.sh /app/entrypoint.sh
  
RUN useradd mumble \
  && apt-get update \
  && apt-get install -y mumble-server \
  && mkdir -p /opt/mumble/data \
  && chown -R mumble /app \
  && chown mumble /opt/mumble/data

EXPOSE 64738
USER mumble

ENTRYPOINT ["/app/entrypoint.sh"]
