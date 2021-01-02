## Introduction

This is a dummy application which can run PHP applications inside a stable docker environment.
Both processes (PHP and Nginx) are supervised which also is the first process (PID 1).

## Requirements

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
