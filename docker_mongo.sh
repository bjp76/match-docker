#!/bin/bash

eval "$(docker-machine env default)"
echo "Docker Containers:"
docker ps -a
echo 
echo "Docker Images:"
docker images

echo
read -p "Continue? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo 
echo "Pulling images to be used"
docker pull mongo:3.2.4

echo
echo "Start DB Instance"
mkdir /tmp/mongodb
docker run -d -v /tmp/mongodb -p 27017:27017 --name mongodb -e MONGODB_DBNAME=match mongo:3.2.4

echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
