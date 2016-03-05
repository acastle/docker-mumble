FROM ubuntu:14.04
MAINTAINER Alex Castle <agcastle64@gmail.com>

ENV MUMBLE_WELCOME_TEXT="<br />Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay!<br />" \
  MUMBLE_PASSWORD="" \
  MUMBLE_BANDWIDTH=72000 \
  MUMBLE_USERS=100 \
  HOME = /app

ADD mumble-server.ini /app/config/mumble-server-template.ini
ADD entrypoint.sh /app/entrypoint.sh
  
RUN useradd mumble \
  && apt-get update \
  && apt-get install -y mumble-server \
  && mkdir -p /app/data \
  && mkdir -p /app/logs \
  && mkdir -p /app/certs \
  && chown -R mumble /app \
  && chmod -R 775 /app

VOLUME ["/app/data", "/app/logs", "/app/certs"]
EXPOSE 64738
USER mumble

ENTRYPOINT ["/app/entrypoint.sh"]