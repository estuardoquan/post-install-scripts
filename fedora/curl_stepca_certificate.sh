#!/bin/bash

OPTS=$(getopt -o o:s --long out:,secure -- "$@")

if [ $? -ne 0 ]; then
  echo "Failed to parse options" >&2
  exit 1
fi

eval set -- "$OPTS"

OUT=/etc/pki/ca-trust/source/anchors/roots.pem
SECURE=false

while true; do
    case "$1" in
        -s | --secure)
            SECURE=true
            shift
            ;;
        -o | --out)
            OUT=$2
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!"
            exit 1
            ;;
  esac
done

URL=$1

set -- \
    -o $OUT 

if [ "$SECURE" = false ]; then
    set -- $@ \
        -k
fi

set -- $@ $URL

curl $@
chmod 644 $OUT
update-ca-trust

