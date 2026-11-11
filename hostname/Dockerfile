FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

# hadolint ignore=DL3018
RUN apk add --no-cache curl jq

COPY entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

CMD ["/usr/src/entrypoint.sh"]
