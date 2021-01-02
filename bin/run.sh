#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
IMAGE_NAME="docker-php-nginx"
APP_DIR=$(readlink -f "$DIR/../app")

if [ -z "$1" ]; then
  echo "You have to supply at least one argument."
  exit 0
fi;

docker run \
  --rm \
  -u www \
  -v "$APP_DIR":/var/www \
  "$IMAGE_NAME" \
  sh -c "$1" \

exit 0