FROM php:8.1.30-apache

# Update package list and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    neovim \
    libapache2-mod-security2 \
    apparmor \
    apparmor-utils \
    curl \
    wget \
    git \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    autoconf \
    gcc \
    make \
    libcurl4-openssl-dev \
    unzip \
    zip \
    ca-certificates \
    iputils-ping \
    dnsutils \
    iproute2 \
    iptables \
    sudo \
    systemd \
    default-mysql-client \
    graphviz \
    netcat-openbsd \
    openssh-client \
    valgrind \
    redis \
    && rm -rf /var/lib/apt/lists

RUN docker-php-ext-install \
    zip \
    pdo \
    pdo_mysql \
    curl\
    bcmath \
    mysqli \
    gettext \
    opcache \
    shmop

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite headers

# Create necessary folders
RUN mkdir -p /etc/ssl/ \
    /etc/ssl/certs \
    /etc/ssl/private \
    /etc/apache2 \
    /COMMON \
    /var/www/html \
    /var/www/html/tools

# Update config to allow SSL connection
COPY config/apache2/ /etc/apache2/

# copy php.ini
COPY config/usr/local/etc/php/ /usr/local/etc/php/

# Enable SSL module and install necessary extensions
RUN docker-php-ext-install mysqli

# copy certs
COPY config/etc/ssl/ /etc/ssl/

# Copy Composer Image
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Configure Apache to use SSL
# Enable SSL module and install necessary extensions
RUN a2enmod ssl
RUN a2ensite default-ssl

RUN chmod -fR 755 /etc/apache2 \
    /etc/ssl/certs \
    /etc/ssl/private

# Copy your PHP code into the container
COPY src/ /var/www/html/

RUN chmod -fR 770 /var/www/html

RUN chmod -fR 777 /var/log/

RUN chown -fR www-data:www-data /var/www/html

# RUN timedatectl set-timezone Asia/Singapore

WORKDIR /var/www/html
USER www-data

# Expose ports
EXPOSE 5080
EXPOSE 5043