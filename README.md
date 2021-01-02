## Introduction

This is a dummy application which can run PHP applications inside a stable docker environment.
Both processes (PHP and Nginx) are supervised which also is the first process (PID 1). The size 
of the base image currently is ~76 MB.

## Provided packages

- supervisor
- curl
- php7-fpm
- php7-json
- php7-ldap
- php7-curl
- php7-pdo
- php7-pdo_mysql
- php7-pdo_sqlite
- php7-simplexml
- php7-dom
- php7-ctype
- php7-tokenizer
- php7-xml
- php7-xmlwriter
- php7-session
- composer
- nginx

## Required packages

- make
- docker
- docker-compose
- openssl

## Installation

```
./docker-php-nginx $> make certificates
./docker-php-nginx $> make install
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

## Run commands in the container

If you want to run custom commands inside the container you 
can use the Shell Script in the ```./bin```-Folder. 
The usage would be ```./bin/run.sh "Your command"``` (with quotes).

## Default URL

Call [localhost](https://localhost) in your favorite Browser.
You probably have to accept the custom certificate warning.
