#!/bin/bash

RESOLVED_DOMAINS=${RESOLVED_DOMAINS:-}
RESOLVED_DNS=${RESOLVED_DNS:-8.8.8.8}
RESOLVED_FALLBACK=${RESOLVED_FALLBACK:-1.1.1.1}
RESOLVED_OUT=${RESOLVED_OUT:-/etc/systemd/resolved.conf}

set -- \
    "[Resolve]" \
    "DNS=${RESOLVED_DNS}" \
    "FallbackDNS=${RESOLVED_FALLBACK}"

if [ -n "${RESOLVED_DOMAINS}" ]; then
    set -- $@ \
        "Domains=${RESOLVED_DOMAINS}"
fi

printf "%s\n" $@ > ${RESOLVED_OUT}
