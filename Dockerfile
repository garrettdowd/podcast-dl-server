#
# podcast-dl Server Dockerfile
#
# https://github.com/garrettdowd/podcast-dl-server
#

FROM python:slim

WORKDIR /usr/local/bin/

RUN apt update \
  && apt upgrade \
  && wget https://github.com/lightpohl/podcast-dl/releases/latest/download/podcast-dl-linux-x64 \
  && mv podcast-dl-linux-x64 podcast-dl \
  && chmod +x podcast-dl \
  && pip install bottle \
  && mkdir /downloads \
  && mkdir -p /usr/src/app

WORKDIR /usr/src/app
COPY . /usr/src/app

EXPOSE 8567

VOLUME ["/downloads"]

#CMD ["tail","-f","/dev/null"]
CMD [ "python", "-u", "podcast-dl-server.py" ]
