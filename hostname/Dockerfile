FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

# hadolint ignore=DL3018
RUN apk add --no-cache curl jq

COPY entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

CMD ["/usr/src/entrypoint.sh"]
