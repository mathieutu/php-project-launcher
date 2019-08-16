FROM richarvey/nginx-php-fpm
COPY nginx-site.conf /etc/nginx/sites-available/default.conf
RUN apk update
RUN apk add --no-cache postgresql-dev
RUN apk add --no-cache yarn
RUN docker-php-ext-install pdo pdo_pgsql bcmath
