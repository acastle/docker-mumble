FROM ubuntu:14.04
MAINTAINER Alex Castle <agcastle64@gmail.com>

ENV MUMBLE_WELCOME_TEXT="<br />Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay!<br />" \
  MUMBLE_PORT=64738 \
  MUMBLE_HOST=0.0.0.0 \
  MUMBLE_PASSWORD="" \
  MUMBLE_BANDWIDTH=72000 \
  MUMBLE_USERS=100

ADD mumble-server.ini /app/config/mumble-server-template.ini
ADD entrypoint.sh /app/entrypoint.sh
  
RUN useradd mumble \
  && apt-get update \
  && apt-get install -y mumble-server \
  && mkdir -p /app/data \
  && chown -R mumble /app \
  && chmod -R 775 /app

VOLUME ["/app/data"]
EXPOSE 64738
USER mumble

ENTRYPOINT ["/app/entrypoint.sh"]
