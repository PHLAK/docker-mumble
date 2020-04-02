#!/usr/bin/env sh

if [[ ! -z ${SUPERUSER_PASSWORD} ]]; then
    /opt/mumble/murmur.x86 -ini ${CONFIG_PATH} -supw ${SUPERUSER_PASSWORD}
fi

exec /opt/mumble/murmur.x86 -fg -ini ${CONFIG_PATH}
