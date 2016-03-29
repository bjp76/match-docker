#!/bin/bash

eval "$(docker-machine env default)"
echo "Docker Containers:"
docker ps -a
echo 
echo "Docker Images:"
docker images

echo
read -p "Ensure Docker container to be created is not already listed above. Continue? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo 
read -p "Rebuild Docker image from latest code in ~/git/treatment-arm-api/treatment_arm_api? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    docker build -t matchbox/tarm ~/git/treatment-arm-api/treatment_arm_api/
fi

echo
echo "Start TreatmentArmAPI Instance"
docker run -d --name TreatmentArm --link mongodb -p 10235:10235 matchbox/tarm

echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
