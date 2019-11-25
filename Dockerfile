FROM node:12.11.0

RUN apt-get update && \
    apt-get install -y \
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
        dirmngr \
        redis-server \
        nginx

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | apt-key add - && \
    echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN apt-get update && \
    apt-get install -y \
    mongodb-org=3.6.15 \
    mongodb-org-server=3.6.15 \
    mongodb-org-shell=3.6.15 \
    mongodb-org-mongos=3.6.15 \
    mongodb-org-tools=3.6.15

COPY mongodb/initd /etc/init.d/mongod
RUN chmod +x /etc/init.d/mongod

# Install Hapify CLI
RUN npm install -g hapify-cli@0.5.6

# Clone the boilerplates
RUN mkdir /app
RUN cd /app && git clone --branch v2.0.1 https://github.com/Tractr/boilerplate-hapijs.git
RUN cd /app && git clone --branch v2.0.2 https://github.com/Tractr/boilerplate-ngx-components.git
RUN cd /app && git clone --branch v2.0.2 https://github.com/Tractr/boilerplate-ngx-dashboard.git

# Prepare boilerplates
RUN cd /app/boilerplate-hapijs && npm install
RUN cd /app/boilerplate-ngx-components && npm install
RUN cd /app/boilerplate-ngx-dashboard && npm install

# Configure Nginx
COPY nginx/default.conf /etc/nginx/sites-available/default

# Configure image
VOLUME /app
EXPOSE 3000 8000 8001
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
