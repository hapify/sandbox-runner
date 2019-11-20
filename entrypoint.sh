#!/bin/bash

set -eo pipefail

if [[ -z "$HPF_KEY" ]]; then
    echo -e "You must specify an API key with env HPF_KEY"
    exit 1
fi

if [[ -z "$HPF_PROJECT" ]]; then
    echo -e "You must specify a project id with env HPF_PROJECT"
    exit 1
fi

PORT="${HPF_PORT:-4800}"
HOST="${HPF_HOSTNAME:-localhost}"
API_URL="${HPF_API_URL:-https://api.hapify.io/v1}"

hpf config --apiKey ${HPF_KEY}

if [[ ! -z "$HPF_API_URL" ]]; then
    hpf config --apiUrl ${HPF_API_URL}
fi

hpf -d /app use -p ${HPF_PROJECT}

hpf --debug -d /app serve -p ${PORT} -H ${HOST} --no-open
