#!/bin/sh

if [[ ! "${SUPERUSER_PASSWORD}" == "" ]]; then
    /opt/mumble/murmur.x86 -ini ${CONFIG_PATH} -supw ${SUPERUSER_PASSWORD}
    echo "Password for 'SuperUser' was set from environment variable"
    unset SUPERUSER_PASSWORD
fi

exec $(echo "$@" | envsubst)
