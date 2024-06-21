# .gitpod.Dockerfile

# Use the official Gitpod base image for PHP
FROM gitpod/workspace-full

USER root

# Install MySQL client and server
RUN apt-get update \
    && apt-get install -y mysql-server mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP and Laravel dependencies
RUN apt-get install -y php7.4 php7.4-mysql php7.4-sqlite php7.4-bcmath php7.4-mbstring \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install phpMyAdmin
RUN apt-get install -y phpmyadmin
RUN ln -s /usr/share/phpmyadmin /workspace/phpmyadmin

# Expose ports for Laravel development
EXPOSE 8000

# Start MySQL service
CMD ["service", "mysql", "start"]
