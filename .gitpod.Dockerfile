# Dockerfile

# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive mode during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    php7.4 \
    php7.4-cli \
    php7.4-mysql \
    php7.4-sqlite \
    php7.4-bcmath \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-curl \
    php7.4-json \
    php7.4-zip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install MySQL server and client
RUN apt-get update && apt-get install -y mysql-server mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install phpMyAdmin (optional, if needed)
RUN apt-get update && apt-get install -y phpmyadmin \
    && ln -s /usr/share/phpmyadmin /workspace/phpmyadmin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose ports for Laravel (if needed)
EXPOSE 8000

# Start MySQL service (if needed)
CMD ["service", "mysql", "start"]

# Set working directory for Laravel application (adjust as per your project structure)
WORKDIR /workspace/laravel_5
