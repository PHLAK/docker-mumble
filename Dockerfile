FROM alpine:3.2
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Define Mumble version
ENV MUMBLE_VERSION 1.2.12

# Create Mumble directories
ENV MUMBLE_DIR  /opt/mumble
ENV CONFIG_DIR  /srv/mumble
ENV SCRIPTS_DIR /srv/scripts
RUN mkdir -pv ${MUMBLE_DIR} ${CONFIG_DIR}

# Copy config file
COPY files/config.ini ${CONFIG_DIR}/config.ini

# Copy SuperUser password update script
COPY files/update-pw ${SCRIPTS_DIR}/update-pw
RUN chmod +x ${SCRIPTS_DIR}/update-pw

# Install dependencies
RUN apk add --update ca-certificates bzip2 tar wget \
    && rm -rf /var/cache/apk/*

# Download and extract Mumble
RUN wget -qO- https://github.com/mumble-voip/mumble/releases/download/${MUMBLE_VERSION}/murmur-static_x86-${MUMBLE_VERSION}.tar.bz2 \
    | tar -xjv --strip-components=1 -C ${MUMBLE_DIR}

# Expose ports
EXPOSE 64738 64738/udp

# Set volumes
VOLUME ${CONFIG_DIR}

# Default command
CMD ${MUMBLE_DIR}/murmur.x86 -fg -ini ${CONFIG_DIR}/config.ini
