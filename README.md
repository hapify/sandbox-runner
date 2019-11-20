# Sandbox runner

A Docker image to run demo project quickly

## Docker

### Build this image

```bash
docker build . -t hpf-sandbox-runner
```

### Run this image

```bash
docker run -d \
       -e HPF_KEY=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_PROJECT=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_API_URL=https://api.hapify.io/v1 \
       --name hpf-sandbox-runner \
       hapify/sandbox-runner
```
