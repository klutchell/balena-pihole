FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

# hadolint ignore=DL3018
RUN apk add --no-cache curl jq

COPY entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

CMD ["/usr/src/entrypoint.sh"]
