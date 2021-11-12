#!/bin/sh
SCRIPT_VERSION="1.0.0"

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    . ./scripts/help.sh ${@: -1}
    exit 1
fi

if [ "$1" = "new" ]; then
    if [ "$2" = "-h" ] || [ "$2" = "--help" ]; then
        . ./scripts/new-service/help.sh
        exit 1
    fi
    PARAMETERS=("$@")
    . ./scripts/new-service/new-service.sh
fi

if [ "$1" = "configure" ]; then
    if [ "$2" = "-h" ] || [ "$2" = "--help" ]; then
        . ./scripts/configure/help.sh
        exit 1
    fi
    PARAMETERS=("$@")
    . ./scripts/configure/configure.sh
fi
