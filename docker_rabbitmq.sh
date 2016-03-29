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
docker pull rabbitmq:3.6.1-management

echo
echo "Start RabbitMQ Instance"
docker run -d --hostname rabbitmq --name rabbitmq -e RABBITMQ_DEFAULT_USER=guest -e RABBITMQ_DEFAULT_PASS=guest -p 15672:15672 -p 5672:5672 matchbox/rabbitmq:3.6.1

echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
