# https://hub.docker.com/_/alpine/
FROM alpine:3.12.8

# hadolint ignore=DL3018
RUN apk add --no-cache bash docker-cli iptables

WORKDIR /usr/src/app

COPY run.sh .

RUN chmod +x run.sh

CMD [ "/usr/src/app/run.sh" ]
