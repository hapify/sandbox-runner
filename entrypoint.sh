#!/bin/bash

# ===============================================
set -eo pipefail

if [[ -z "$HPF_KEY" ]]; then
    echo -e "You must specify an API key with env HPF_KEY"
    exit 1
fi

if [[ -z "$HPF_PROJECT" ]]; then
    echo -e "You must specify a project id with env HPF_PROJECT"
    exit 1
fi

if [[ -z "$API_URL" ]]; then
    echo -e "You must specify an Api URL"
    exit 1
fi

# ===============================================
# Start services
service redis-server start
service mongod start
service nginx start || (cat /var/log/nginx/error.log && exit 1)

# ===============================================
# Add special hosts
echo "127.0.0.1 mongodb redis" >> /etc/hosts

# ===============================================
# Dirty work-around to use admin routes in components
SEARCH="return '<<M a-a>>';";
REPLACE="return 'admin/<<M a-a>>';";
sed -i "s@${SEARCH}@${REPLACE}@g" /app/boilerplate-ngx-components/hapify/src/app/models/model/model.service.ts.hpf
SEARCH=" = true;";
REPLACE=" = false;";
sed -i "s@${SEARCH}@${REPLACE}@g" /app/boilerplate-ngx-components/hapify/src/app/models/model/model.service.ts.hpf

# ===============================================
# Generate project
hpf config --apiKey ${HPF_KEY}
if [[ ! -z "$HPF_API_URL" ]]; then
    hpf config --apiUrl ${HPF_API_URL}
fi
hpf -d /app use -p ${HPF_PROJECT}
hpf --debug -d /app generate

# ===============================================
# Install API
cd /app/boilerplate-hapijs
if [[ ! -d "node_modules" ]]; then
    npm install
fi
npm run cmd setup
npm run cmd insert-admin
# Populate Database
if [[ "$POPULATE_DATABASE" -eq "1" ]]; then
    npm run cmd populate
fi

# ===============================================
# Change API URL
SEARCH="https://api.example.com";
sed -i "s@${SEARCH}@${API_URL}@g" /app/boilerplate-ngx-dashboard/src/environments/environment.production.ts
sed -i "s@${SEARCH}@${API_URL}@g" /app/boilerplate-ngx-components/src/environments/environment.production.ts

# ===============================================
# Build dashboard
cd /app/boilerplate-ngx-dashboard
if [[ ! -d "node_modules" ]]; then
    npm install
fi
npm run build:production-quick

# ===============================================
# Build components
cd /app/boilerplate-ngx-components
if [[ ! -d "node_modules" ]]; then
    npm install
fi
npm run build:production-quick

# ===============================================
# Start API
cd /app/boilerplate-hapijs
NODE_ENV=development npm start
