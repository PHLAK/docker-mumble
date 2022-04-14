# fork of PHLAK/docker-mumble

FROM gymnae/alpine-base
MAINTAINER Gunnar Falk <docker@grundstil.de>

# Define Mumble version
#ENV MUMBLE_VERSION 1.4.230 

RUN apk add apk add --no-cache \
    murmur

# add mumble-server user
RUN adduser -DHs /sbin/nologin mumble-server

# Copy config file
ADD config/mumble-server.ini /etc/murmur/murmur.ini

# Expose ports
EXPOSE 64738 64738/udp

COPY /init.sh / 

USER mumble-server

# Set volumes
VOLUME /etc/murmur

# Default command
CMD ["/init.sh"]
