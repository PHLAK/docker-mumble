# fork of PHLAK/docker-mumble

FROM gymnae/alpine-base
MAINTAINER Gunnar Falk <docker@grundstil.de>

# Define Mumble version
#ENV MUMBLE_VERSION 1.4.230 

RUN apk add --no-cache \
    murmur --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

# add mumble-server user
RUN adduser -DHs /sbin/nologin mumble-server

# Copy config file
ADD config/mumble-server.ini /etc/murmur/murmur.ini

# Expose ports
EXPOSE 64738 64738/udp

# copy the init script to root where it's later run as user mumble-server
COPY /init.sh / 

# ensure the user running murmur has all required access rights
RUN chown -R mumble-server:mumble-server /etc/murmur

# switch to the server user
USER mumble-server

# Set volumes
VOLUME /etc/murmur

# Default command
CMD ["/init.sh"]
