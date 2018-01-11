#!/usr/bin/env bash

#
# This script builds the image based on ./Dockerfile. The image
# is the executed with the ./run.sh script.
#

echo $'\nReading environment variables...'
source ./env.sh

echo $'\nRemoving old container...'
docker rm -f $CONTAINER_NAME

echo $'\nRemoving old image(s)...'
docker rmi -f $CONTAINER_IMAGE

echo $'\nCreating volume...'
docker volume create $DATA_VOLUME_NAME

echo $'\nBuilding docker image...'
docker build -t $CONTAINER_IMAGE .
