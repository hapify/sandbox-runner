FROM node:12.11.0

RUN apt-get update && \
    apt-get install -y \
        git \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

RUN npm install -g hapify-cli@0.5.6

RUN mkdir /app
RUN cd /app && git clone --branch v2.0.1 https://github.com/Tractr/boilerplate-hapijs.git
RUN cd /app && git clone --branch v2.0.0 https://github.com/Tractr/boilerplate-ngx-components.git
RUN cd /app && git clone --branch v2.0.0 https://github.com/Tractr/boilerplate-ngx-dashboard.git

VOLUME /app

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
