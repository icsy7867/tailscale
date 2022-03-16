FROM golang:1.16.7-alpine3.14 as builder
WORKDIR /app
COPY . ./
# This is where one could build the application code as well.
# Using https://tailscale.com/kb/1132/flydotio as a reference


FROM alpine:latest as tailscale
WORKDIR /app
COPY . ./
ENV TSFILE=tailscale_1.22.1_amd64.tgz
RUN wget https://pkgs.tailscale.com/stable/${TSFILE} && \
  tar xzf ${TSFILE} --strip-components=1
COPY . ./


FROM alpine:latest
RUN apk update && apk add ca-certificates iptables iproute2 && rm -rf /var/cache/apk/*
# Copy binary to production image
COPY --from=builder /app/start.sh /start.sh
COPY --from=tailscale /app/tailscaled /usr/bin/tailscaled
COPY --from=tailscale /app/tailscale /usr/bin/tailscale
RUN chmod -R 754 /start.sh
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

# Run on container startup.
CMD ["/start.sh"]
