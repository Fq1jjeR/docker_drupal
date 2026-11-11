FROM drupal:10-apache

RUN docker-php-ext-install pdo pdo_sqlite

RUN echo '#!/bin/bash\n\
sed -i "s/Listen 80/Listen ${PORT:-80}/" /etc/apache2/ports.conf\n\
sed -i "s/\*:80/\*:${PORT:-80}/" /etc/apache2/sites-available/000-default.conf\n\
apache2-foreground' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]