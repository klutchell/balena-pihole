FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

# hadolint ignore=DL3018
RUN apk add --no-cache curl jq

COPY entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

CMD ["/usr/src/entrypoint.sh"]
