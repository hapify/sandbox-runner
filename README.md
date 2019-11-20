# Sandbox runner

Simple server for generated app sample

## Docker

### Build this image

```bash
docker build . -t hpf-sandbox-runner
```

### Run this image

```bash
docker run -it --rm \
       -p 4800:4800 \
       -e HPF_KEY=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_PROJECT=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_PORT=4800 \
       -e HPF_HOSTNAME=domain.com \
       -e HPF_API_URL=https://api.hapify.io/v1 \
       --name hpf-sandbox-runner \
       hapify/sandbox-runner
```
