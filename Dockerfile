FROM drupal:10-apache

# Устанавливаем зависимости для сборки pdo_sqlite
RUN apt-get update && apt-get install -y libsqlite3-dev && rm -rf /var/lib/apt/lists/*

# Устанавливаем только pdo_sqlite (PDO уже есть в образе)
RUN docker-php-ext-install pdo_sqlite

ENV PORT=80

# Переопределяем порт Apache на значение из переменной окружения
CMD sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf && \
    sed -i "s/\*:80/\*:${PORT}/" /etc/apache2/sites-available/000-default.conf && \
    apache2-foreground