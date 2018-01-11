#!/usr/bin/env bash

# The location of this script. The place where the data directory
# `basicdata` is located.
export RUN_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

echo "Reading environment variables..."
source ./env.sh

echo "Removing old container..."
docker rm -f $CONTAINER_NAME

# docker run
# -e           Specify environment variable
# -p           forwards TCP traffic from localhost's port $HOST_PORT to the
#              port $CONTAINER_PORT inside the container
# --name       gives the container the name that shows up with `docker ps -a`
# --volume     maps $HOST_DATA_DIRECTORY to the container so it shows 
#              up as $CONTAINER_DATA_DIRECTORY
# -d           Leave running in the background ('daemon')
#
# $CONTAINER_IMAGE is the image used to build the container, 
#             `docker images` lists all images on this host.

# MS SQL sysadmin username=SA password=VeryVeryS3cret

echo "Starting MS SQL Server..."
docker run \
  -e 'ACCEPT_EULA=Y' \
  -e 'MSSQL_PID=Express' \
  -e 'SA_PASSWORD=VeryVeryS3cret' \
  -p $HOST_PORT:$CONTAINER_PORT \
  --name $CONTAINER_NAME \
  --volume $DATA_VOLUME_NAME:/var/opt/mssql \
  -d \
  $CONTAINER_IMAGE
