![Docker Stars Shield](https://img.shields.io/docker/stars/garrettdowd/podcast-dl-server.svg?style=flat-square)
![Docker Pulls Shield](https://img.shields.io/docker/pulls/garrettdowd/podcast-dl-server.svg?style=flat-square)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/garrettdowd/podcast-dl-server/master/LICENSE)

# podcast-dl-server

Very spartan Web and REST interface for downloading podcasts onto a server. Inspired and heavily derived from [youtube-dl-server](https://github.com/manbearwiz/youtube-dl-server). [`bottle`](https://github.com/bottlepy/bottle) + [`podcast-dl`](https://github.com/lightpohl/podcast-dl).

![screenshot][1]

## Running

### Docker CLI

This example uses the docker run command to create the container to run the app. Here we also use host networking for simplicity. Also note the `-v` argument. This directory will be used to output the resulting podcasts

```shell
docker run -d --net="host" --name podcast-dl -v /downloads:/path-to-download-folder garrettdowd/podcast-dl-server
```

### Docker Compose

This is an example service definition that could be put in `docker-compose.yml` which can be downloaded [here](https://raw.githubusercontent.com/garrettdowd/podcast-dl-server/master/docker-compose.yml).

```yml
---
version: "2"
services:
  podcast-dl:
    container_name: podcast-dl
    image: garrettdowd/podcast-dl-server
    volumes:
      - /downloads:/path-to-download-folder
    ports:
      - 8567:8567
    restart: unless-stopped
```

## Usage

### Start a download remotely

Downloads can be triggered by supplying the `{{url}}` of the requested podcast through the Web UI or through the REST interface via curl, etc.

#### HTML

Just navigate to `http://{{host}}:8080/podcast-dl` and enter the requested `{{url}}`.

#### Curl

```shell
curl -X POST --data-urlencode "url={{url}}" http://{{host}}:8080/podccast-dl/q
```

#### Fetch

```javascript
fetch(`http://${host}:8080/podcast-dl/q`, {
  method: "POST",
  body: new URLSearchParams({
    url: url
  }),
});
```


## Implementation

The server uses [`bottle`](https://github.com/bottlepy/bottle) for the web framework and [`podcast-dl`](https://github.com/lightpohl/podcast-dl) to handle the downloading.

This docker image is based on [`python:alpine`](https://registry.hub.docker.com/_/python/) and consequently [`alpine:3.8`](https://hub.docker.com/_/alpine/).

[1]:youtube-dl-server.png
