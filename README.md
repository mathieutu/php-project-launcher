# 🚀 PHP Project Launcher

Set a flexible Docker development environment in a second.
This package assumes that you have docker installed, and a bash compatible operating system (actually not tested on Windows). 

## Set your project services
Just once per project, in its root sources folder.

If the services are already set up for your project you can directly jump to "[Launch the services](#launch-the-services)" chapter.

### 📦 Require the package
```sh
$ composer require mathieutu/php-project-launcher
```

*Tip: You should commit here! 😇*

### 🐳 Initialize Docker files
```sh
$ ./vendor/bin/ppl init {project-name?}
```
*Tip: You can personalize the project name, or leave empty to use the directory name. 
It will be used to automatically set your domain names: `project-name.test` and `project-name.localhost` by default. 
To use `*.test` the developer need to edit its `hosts` or [add a dns server](https://medium.com/@narakuw/brew-install-dnsmasq-in-macos-sierra-26021c824be8), 
but `*.localhost` should work out of the box in unix OS*

### 📝 Choose your flavour

Edit the `docker-compose.yml`, `docker/*`, and `.env` files to fit your needs.

A standard Laravel 5 / Symfony 4 application with a PostgreSQL database should work out of the box after [updating your `.env` file](#update-your-env-file).  

See the [configuration chapter](#make-the-configuration-all-yours) for all the details.

*Tip: You also should commit here 😇!*

## Launch the services
For each developer on its computer, every time s‧he need to launch the project.

### 🚀 Launch your project
```sh
$ ./vendor/bin/ppl up

```
*Tip: A container of [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) will be launched with `nginx-proxy` name if not found. It will allow you to use several domain names for your projects*

## 🎉 Make great things

### Update your `.env` file

With the `ppl db` command you will see all the values that you need for your `.env` file: 
```sh
$ ./vendor/bin/ppl db
From the container:
    DB_CONNECTION=pgsql
    DB_HOST=db
    DB_PORT=5432
    DB_USERNAME=root
    DB_PASSWORD=
    DB_DATABASE=local
    DATABASE_URL=postgresql://root:@db:5432/local
...
```
### See your project in the browser
```sh
$ ./vendor/bin/ppl open {path?}

```
*Tip: If you do it quickly after `up` command, you could see a 502 page. Hold tight and refresh after few seconds, it's just the time your server needs to start!*

*Tip²: You can customize the domain to open with the `$PPL_OPEN` env variable in web service.*

### See your database content in a dedicated software
You can see the public port of your database with:
```sh
$ ./vendor/bin/ppl db
...
From outside:
    Type: PostgresSQL
    Host: 127.0.0.1
    Port: 32813
    Username: root
    Password: 
    Database: local
    Url: postgresql://root:@127.0.0.1:32813/local
```


### And more...
You can see all you can do with:

```text
$ ppl --help

PHP Project Launcher.

Usage:
  ./vendor/bin/ppl [COMMAND] [ARGS...]
  ./vendor/bin/ppl -h | --help

Commands:
  init               Install the docker files to set the services. Can be used with project name in parameter.
  up | u             Run the project services (run the proxy if not already launched).
  down | d           Stop and remove the project services.
  reload | rl        Down and up the project services.
  open | o           Open project in web browser.
  database | db      Show the env variables and the database connection information.           
  ports | p          List private -> public binding ports. Can be used with service name in parameter.
  artisan | a        Execute Laravel Artisan in web service (with access to DB).
  console | sf       Execute Symfony Console in web service (with access to DB).
  composer | c       Execute Composer in web service (with proper version of php).
  yarn | y           Execute Yarn in project (with Node v10, linux environment).
  bash | sh          Open a bash console in web service.
  inspect | i        Show the docker configuration for a service.
  logs               View output from services.
  ps                 List services.
  *                  Fallback on docker-compose binary.

```

*Tip: By adding `./vendor/bin/` to your path, you will be able to directly type `ppl` instead of `./vendor/bin/ppl`. And it will be useful for all the composer binaries, like `phpunit`! For that, you just have to add `export PATH=∼/.composer/vendor/bin:$PATH` to your .bashrc, or .zshrc file.*


## Make the configuration all yours

A standard Laravel/Symfony application with a PostgreSQL database should work out of the box, after having configured your `.env` file.

Uncomment the mysql example in `docker-compose.yml` if you prefer to use it.

For now, in the original flavour, you can see the documentation pages of:

- [jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy/): The reverse proxy that allows you to use domain names on your projects.
- [richarvey/nginx-php-fpm](https://hub.docker.com/r/richarvey/nginx-php-fpm/): The image used to serve the web service. Directly shipped with git, nginx, php, composer, xdebug, etc.
- [postgres](https://hub.docker.com/_/postgres/) and [mysql](https://hub.docker.com/_/mysql/) databases containers.
- [docker](https://docs.docker.com/get-started/) and [docker-compose](https://docs.docker.com/compose/overview/) tools.


### Customize your URLs
In the `docker-compose.yml` file, you will be able to customise several env variables in your web service:
- `$VIRTUAL_HOST` which is the list of all the domain names that the proxy will redirect to this container.
- `$PPL_OPEN` which is the root url that the command `ppl open` will use.


**TO BE CONTINUED...**

## Contribute to this project

Please feel ~~free~~ encouraged to make Issues and Pull Requests, for new features and bugs fixes as well as documentation. 
