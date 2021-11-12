## Introduction

This is a dummy application which can run PHP applications inside a stable docker environment.
Both processes (PHP and Nginx) are supervised which also is the first process (PID 1). The size 
of the base image currently is ~85 MB.

## Provided packages

- supervisor
- curl
- php8-fpm
- php8-json
- php8-ldap
- php8-curl
- php8-pdo
- php8-pdo_mysql
- php8-pdo_sqlite
- php8-simplexml
- php8-dom
- php8-ctype
- php8-mbstring
- php8-tokenizer
- php8-xml
- php8-xmlwriter
- php8-session
- composer
- nginx

## Required packages

- make
- docker
- docker-compose
- openssl

## Installation

First, you have to configure your `PROJECT_NAME` within the .env file.
Rename (or copy) the containing `.env.dist` file to `.env` and adjust 
the containing variable.

The following command should only be called once for the initial setup. 
If you need to rebuild the container e.g. because of filesystem changes you 
can run `make install` over again.

```bash
./docker-php-nginx $> make setup
```

## Development

Place your code inside the ```app``` folder. Everything in there is 
getting mounted into the container. The Webserver is pointing to a 
file named ```index.php``` in the ```public``` folder. The absolute 
path within the container is ```/var/www/public```.

You can use the existing ```bootstrap.php``` to start with your application. 
Usually you'll create a ```src``` folder beside the ```public``` and ```vendor``` folder. 
The ```src``` folder is where your application logic lives.

You can also safely include assets like JavaScript or Stylesheets in an absolute way, like ```/css/main.css```as 
the mentioned ```public``` folder is the server root directory.

## Connect to the container

```bash
./docker-php-nginx $> make ssh
```

## Run commands in the container

If you need to execute your own commands within the container, you can use the provided 
shell script in the ```bin``` directory. It also respects the user permissions as it's 
running with the ```www``` user. You don't have to fight with scrambled permissions 
on your host machine anymore.

Usage: ```./bin/run.sh "composer install"```

## Rebuilding the container/image

In some cases you have to rebuild your image and container, especially if you're adding 
files within the ```rootfs``` directory. Most of the time you have to delete the whole setup 
and rebuild it to prevent the docker layer cache from kicking in. Because of the way the 
image is build in this repository, Docker is able to detect changes in the source of every layer.
This means you can safely just run ```make install``` again and rely on getting your 
expected changes into the container. The cache is still active though.

```bash
./docker-php-nginx $> make install
```

## Default URL

Call [localhost](https://localhost) in your favorite Browser.
You probably have to accept the custom certificate warning.
