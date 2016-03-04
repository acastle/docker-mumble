FROM ubuntu:14.04
MAINTAINER Alex Castle <agcastle64@gmail.com>

ENV MUMBLE_WELCOME_TEXT="<br />Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay!<br />" \
  MUMBLE_PORT=64738 \
  MUMBLE_HOST=0.0.0.0 \
  MUMBLE_PASSWORD="" \
  MUMBLE_BANDWIDTH=72000 \
  MUMBLE_USERS=100

ADD mumble-server.ini /etc/mumble/mumble-server.ini

RUN useradd mumble \
  && apt-get update \
  && apt-get install -y mumble-server \
  && mkdir /opt/mumble/data \
  && chown mumble /opt/mumble/data

RUN sed -i -e 's/{{MUMBLE_WELCOME_TEXT}}/${MUMBLE_WELCOME_TEXT}/g' /etc/mumble/mumble-server.ini \
  && sed -i -e 's/{{MUMBLE_PORT}}/${MUMBLE_PORT}/g' /etc/mumble/mumble-server.ini \
  && sed -i -e 's/{{MUMBLE_HOST}}/${MUMBLE_HOST}/g' /etc/mumble/mumble-server.ini \
  && sed -i -e 's/{{MUMBLE_PASSWORD}}/${MUMBLE_PASSWORD}/g' /etc/mumble/mumble-server.ini \
  && sed -i -e 's/{{MUMBLE_BANDWIDTH}}/${MUMBLE_BANDWIDTH}/g' /etc/mumble/mumble-server.ini \
  && sed -i -e 's/{{MUMBLE_USERS}}/${MUMBLE_USERS}/g' /etc/mumble/mumble-server.ini \

EXPOSE 64738
USER mumble

ENTRYPOINT ["/usr/sbin/murmurd", "-fg", "-ini", "/etc/mumble/mumble-server.ini"]
