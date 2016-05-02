#!/bin/bash

echo
echo
echo "---------- Starting DynamoDB-Local -----------------------------------------------------------------"
echo

eval "$(docker-machine env default)"
echo "Docker Containers:"
docker ps -a

echo
read -p "Ensure Docker container to be created is not already listed above. Continue? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo 
echo "Pulling images to be used"
docker pull matchbox/dynamodb-local:latest

echo
echo "Start DB Instance"
docker run -d -p 8000:8000 --name dynamodb matchbox/dynamodb-local -inMemory -port 8000

echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
