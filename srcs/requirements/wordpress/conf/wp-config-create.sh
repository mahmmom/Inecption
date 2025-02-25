#!/bin/sh

# Check if wp-config.php exists
if [ ! -f wp-config.php ]; then
    echo "Setting up WordPress..."

    # Download WordPress
    wget https://wordpress.org/latest.zip
    unzip latest.zip
    cp -rf wordpress/* .
    rm -rf wordpress latest.zip

    # Create wp-config.php using environment variables
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASS" \
        --dbhost="mariadb" \
        --path="/var/www/html" \
        --allow-root

    # Install WordPress
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="MohaMoha Personal Blog" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path="/var/www/html" \
        --allow-root

    # Create additional user
    wp user create \
        "$WP_USER_LOGIN" \
        "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --path="/var/www/html" \
        --allow-root
else
    echo "WordPress is already set up."
fi

# Set permissions
chown -R nobody:nobody /var/www/html
chmod -R 755 /var/www/html

# Start PHP-FPM
php-fpm83 -F
