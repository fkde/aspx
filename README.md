## Introduction

This repository aims to supply a small as possible docker environment, readily preconfigured with PHP and Nginx.
Both processes (PHP and Nginx) are supervised which also is the first process (PID 1). The size
of the base image currently is ~89 MB.

## Provided packages

- supervisor
- curl
- php82-fpm
- php82-json
- php82-ldap
- php82-curl
- php82-pdo
- php82-pdo_mysql
- php82-pdo_sqlite
- php82-simplexml
- php82-dom
- php82-ctype
- php82-tokenizer
- php82-xml
- php82-xmlwriter
- php82-session
- php82-pecl-xdebug
- composer
- nginx

## Required packages

- make
- docker
- docker-compose
- openssl

## Installation

First, copy the File `.env.dist` into the same directory but name it `.env`. 
Open the newly created dotenv file and adjust the containing environment variables 
to your needs.

Example:
```bash
PROJECT_NAME=my-fancy-project-name
```
Afterwards, execute the following command in your shell.
```bash
./docker-php-nginx $> make first-install
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

## Run commands within the container

If you need to execute your own commands within the container, you can use the provided
shell script in the ```bin``` directory. It also respects the user permissions as it's
running with the ```www``` user. You don't have to fight with scrambled permissions
on your host machine anymore.

Example: 
```bash
./docker-php-nginx $> ./bin/run.sh "composer install"
```

You can also run commands as root, which is sometimes useful.

Example:
```bash
./docker-php-nginx $> ./bin/run.sh "apt-get install" true
```

## Debugging with Xdebug

Execute the following command to enable Xdebug:
```bash
./docker-php-nginx $> make xdebug-on
```

Disable it with the following command:
```bash
./docker-php-nginx $> make xdebug-off
```

***
**Note** | 
The Xdebug service is listening on Port 9003, please respect that in your configuration.
***

## Rebuilding the container/image

In some cases you have to rebuild your image and container, especially if you're adding
files within the ```rootfs``` directory. In a regular setup you have to delete the whole stack
and rebuild it to prevent the docker layer cache from kicking in. Because of the way the
image is build in this repository, Docker is able to detect changes in the source of every layer.
This means you can safely just run ```make install``` again and rely on getting your
expected changes into the container. The cache is still active for unchanged layers though.

## Default URL

Call [localhost](https://localhost) in your favorite Browser.
You probably have to accept the custom certificate warning.
