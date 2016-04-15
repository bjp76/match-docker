#!/bin/bash

echo
echo
echo "---------- Starting Redis --------------------------------------------------------------------"
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
docker pull redis:3.0.7

echo
echo "Start Redis Instance"
docker run --name redis -d redis:3.0.7

echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
