FROM richarvey/nginx-php-fpm
COPY nginx-site.conf /etc/nginx/sites-available/default.conf
RUN apk update && apk add --no-cache postgresql-dev && docker-php-ext-install pdo pdo_pgsql bcmath
