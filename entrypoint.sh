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

# Start services
service redis-server start
service mongod start

# Add special hosts
echo "127.0.0.1 mongodb redis" >> /etc/hosts

# Generate project
API_URL="${HPF_API_URL:-https://api.hapify.io/v1}"
hpf config --apiKey ${HPF_KEY}
if [[ ! -z "$HPF_API_URL" ]]; then
    hpf config --apiUrl ${HPF_API_URL}
fi
hpf -d /app use -p ${HPF_PROJECT}
hpf --debug -d /app generate

# Install API
cd /app/boilerplate-hapijs
npm install
npm run cmd setup
npm run cmd insert-admin

# Start API
NODE_ENV=development npm start
