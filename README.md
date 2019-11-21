# Sandbox runner

A Docker image to run demo project quickly

## Docker

### Build this image

```bash
docker build . -t hpf-sandbox-runner
```

### Run this image

```bash
docker run -it \
       -e HPF_KEY=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_PROJECT=XXXXXXXXXXXXXXXXXXXXX \
       -e HPF_API_URL=https://api.hapify.io/v1 \
       --name hpf-sandbox-runner \
       hapify/sandbox-runner
```


```
docker run -it --rm \
       -e HPF_KEY=Uma5zbAAqXAA6aKjW73j4pVpnuIhilyF2B6Q2ZAtCLJsIK3q \
       -e HPF_PROJECT=5d0a3fa8bbfb050016e850da \
       --name hpf-sandbox-runner \
      runner
```
