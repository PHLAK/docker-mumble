FROM alpine:3.5
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Define Mumble version
ARG MUMBLE_VERSION=1.2.19

# Create Mumble directories
RUN mkdir -pv /opt/mumble /etc/mumble

# Create non-root user
RUN adduser -DHs /sbin/nologin mumble

# Copy config file
COPY files/config.ini /etc/mumble/config.ini

# Copy SuperUser password update script
COPY files/supw /usr/local/bin/supw
RUN chmod +x /usr/local/bin/supw

# Set the bzip archive URL
ARG BZIP_URL=https://github.com/mumble-voip/mumble/releases/download/${MUMBLE_VERSION}/murmur-static_x86-${MUMBLE_VERSION}.tar.bz2

# Install dependencies, fetch Mumble bzip archive and chown files
RUN apk add --update ca-certificates bzip2 tar tzdata wget \
    && wget -qO- ${BZIP_URL} | tar -xjv --strip-components=1 -C /opt/mumble \
    && apk del ca-certificates bzip2 tar wget && rm -rf /var/cache/apk/* \
    && chown -R mumble:mumble /etc/mumble /opt/mumble

# Expose ports
EXPOSE 64738 64738/udp

# Set running user
USER mumble

# Set volumes
VOLUME /etc/mumble

# Default command
CMD ["/opt/mumble/murmur.x86", "-fg", "-ini", "/etc/mumble/config.ini"]
