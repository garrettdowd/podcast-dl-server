#
# podcast-dl Server Dockerfile
#
# https://github.com/garrettdowd/podcast-dl-server
#

FROM node:14-alpine

WORKDIR /usr/local/lib/node_modules/

RUN npm i podcast-dl \
  && apk update \
  && apk add python3 \
  && apk add py3-pip \
  && pip3 install bottle \
  && mkdir /downloads \
  && mkdir -p /usr/src/app

WORKDIR /usr/src/app
COPY . /usr/src/app

EXPOSE 8567

VOLUME ["/downloads"]

CMD [ "python", "-u", "./podcast-dl-server.py" ]