## Introduction

This is a Dummy Application which can run PHP Applications inside a Docker environment. 

## Requirements

- make
- docker
- docker-compose
- openssl

## Installation

```
$> make certificates
$> make install
```

## Usage

### Run commands within the container

If you want to run custom commands inside the container you 
can use the Shell Script in the ```./bin```-Folder. 
The usage would be ```./bin/run.sh "Your command"``` (with quotes).

### The default url

Call [localhost](https://127.0.0.1) in your favorite Browser.
You may have to accept the custom certificate warning.
