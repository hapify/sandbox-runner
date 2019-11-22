# Sandbox runner

A Docker image to run demo project quickly

## Docker

### Build this image

```bash
docker build . -t hpf-sandbox-runner
```

### Run this image

```bash
docker run -it -rm \
       -p 3000:3000 \
       -p 8000:8000 \
       -p 8001:8001 \
       -e HPF_KEY=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_PROJECT=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_API_URL=https://api.hapify.io/v1 \
       -e POPULATE_DATABASE=1 \
       --name hpf-sandbox-runner \
       hapify/sandbox-runner
```

## Login

Use these credentials to log in WebApps:

**username**: admin@example.com

**password**: admin
