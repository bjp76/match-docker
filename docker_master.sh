#!/bin/bash

eval "$(docker-machine env default)"

echo "Running each docker script:"
./docker_mongo.sh
echo
./docker_rabbitmq.sh
echo
./docker_treatmentarm.sh


echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
