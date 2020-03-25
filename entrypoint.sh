#!/bin/sh

if [[ ! "$SUPERUSER_PASSWORD" == "" ]]; then
    /opt/mumble/murmur.x86 -fg -ini $CONFIG_PATH -supw $SUPERUSER_PASSWORD
    echo "SuperUser password set from environment variable"
    unset SUPERUSER_PASSWORD
fi

/opt/mumble/murmur.x86 "$@"