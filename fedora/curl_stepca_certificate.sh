#!/bin/bash

CA_CERTIFICATES_DIR=${CA_CERTIFICATES_DIR:-/etc/pki/ca-trust/source/anchors/roots.pem}
INIT_CA_SECURE=${INIT_CA_SECURE:-0}
INIT_CA_URL=${INIT_CA_URL:-https://localhost:5937/roots.pem}

set -- \
    -O $CA_CERTIFICATES_DIR 

if [ $INIT_CA_SECURE = 0 ]; then
    set -- $@ \
        -k
fi

set -- $@ $INIT_CA_URL

echo $@
#curl $@
#chmod 644 $OUT
#update-ca-trust

