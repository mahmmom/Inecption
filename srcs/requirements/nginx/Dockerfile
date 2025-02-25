FROM alpine:3.20

# Install dependencies
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# Create directories
RUN mkdir -p /etc/nginx/ssl

# Copy main NGINX configuration (includes the http block)
COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# Copy SSL script
COPY ./requirements/nginx/tools/conf.sh /usr/local/bin/conf.sh
RUN chmod +x /usr/local/bin/conf.sh

EXPOSE 443

ENTRYPOINT ["conf.sh"]