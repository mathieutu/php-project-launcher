version: "3"
networks:
  proxy:
    external: true

services:
  web:
    build: ./docker/web
    volumes:
      - .:/var/www/html
    ports:
      - 80
    environment:
      WEBROOT: /var/www/html/public/
      VIRTUAL_HOST: ${PROJECT_NAME}.test, ${PROJECT_NAME}.localhost
      ENABLE_XDEBUG: 1
      PHP_IDE_CONFIG: serverName=${PROJECT_NAME}
      XDEBUG_CONFIG: remote_host=docker.for.mac.localhost
      SKIP_COMPOSER: 1
    depends_on:
      - db
    networks:
      - default
      - proxy

#  scheduler:
#    build: ./docker/scheduler
#    volumes:
#      - .:/var/www/html
#    depends_on:
#      - db

  db:
    image: postgres:10.5
    volumes:
      - ./docker/sql-dumps:/docker-entrypoint-initdb.d
    ports:
      - 5432
    environment:
      POSTGRES_USER: "root"
      POSTGRES_DB: "local"
      POSTGRES_PASSWORD: ""

#  db:
#    image: mysql:5.7
#    volumes:
#      - ./docker/sql-dumps:/docker-entrypoint-initdb.d
#    ports:
#      - 3306
#    environment:
#      MYSQL_ALLOW_EMPTY_PASSWORD: "yes"
#      MYSQL_DATABASE="local"

