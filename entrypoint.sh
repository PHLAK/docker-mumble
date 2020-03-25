#!/bin/sh

if [[ ! "$SUPERUSER_PASSWORD" == "" ]]; then
    /opt/mumble/murmur.x86 -fg -ini $CONFIG_PATH -supw $SUPERUSER_PASSWORD
    echo "SuperUser password set to '$SUPERUSER_PASSWORD'"
    unset SUPERUSER_PASSWORD
fi

/opt/mumble/murmur.x86 "$@"