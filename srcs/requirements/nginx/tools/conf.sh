#!/bin/sh

# Generate SSL certificates if they don't exist
openssl req -x509 -newkey rsa:2048 -days 365 -nodes \
  -keyout "$CERT_KEY" \
  -out "$CERT" \
  -subj "/CN=$HOST_NAME"

# Start NGINX
nginx -g "daemon off;"