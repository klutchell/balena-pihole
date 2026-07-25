FROM alpine:3.24.1

# hadolint ignore=DL3018
RUN apk add --no-cache curl jq

COPY entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

CMD ["/usr/src/entrypoint.sh"]
