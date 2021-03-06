#
# podcast-dl Server Dockerfile
#
# https://github.com/garrettdowd/podcast-dl-server
#

FROM python:alpine

WORKDIR /usr/local/lib/node_modules/

RUN apk update \
  && apk add --update npm \
  && npm i podcast-dl \
  && echo "export PATH=$PATH:/usr/local/lib/node_modules/.bin" >> /etc/profile \
  && pip install bottle \
  && mkdir /downloads \
  && mkdir -p /usr/src/app

ENV PATH=$PATH:/usr/local/lib/node_modules/.bin

WORKDIR /usr/src/app
COPY . /usr/src/app

EXPOSE 8567

VOLUME ["/downloads"]

#CMD ["tail","-f","/dev/null"]
CMD [ "python", "-u", "podcast-dl-server.py" ]
