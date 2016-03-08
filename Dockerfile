# fork of PHLAK/docker-mumble

FROM alpine:3.3
MAINTAINER Gunnar Falk <docker@grundstil.de>

# Define Mumble version
ENV MUMBLE_VERSION 1.2.15

# Create Mumble directories
RUN mkdir -pv /opt/mumble /etc/mumble

# Copy config file
COPY config/mumble-server.ini /etc/mumble/mumble-server.ini

# Copy SuperUser password update script
COPY files/supw /usr/local/bin/supw
RUN chmod +x /usr/local/bin/supw

# Set the bzip archive URL
ENV BZIP_URL https://github.com/mumble-voip/mumble/releases/download/${MUMBLE_VERSION}/murmur-static_x86-${MUMBLE_VERSION}.tar.bz2

# Install dependencies and fetch Mumble bzip archive
RUN apk add --update ca-certificates bzip2 tar wget \
    && wget -qO- ${BZIP_URL} | tar -xjv --strip-components=1 -C /opt/mumble \
    && apk del ca-certificates bzip2 tar wget && rm -rf /var/cache/apk/*

# Expose ports
EXPOSE 64738 64738/udp

# Server password environemnt
ENV SERVERPASSWORD=${SERVERPASSWORD:-}

# Set volumes
VOLUME /etc/mumble

# Default command
CMD ["/opt/mumble/murmur.x86", "-fg", "-ini", "/etc/mumble/config.ini"]
