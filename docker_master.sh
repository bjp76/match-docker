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
echo "Pulling images to be used"
docker pull mongo:3.2.4
docker pull ruby:2.2.4
#docker pull matchbox/treatment-arm-api
docker pull matchbox/tarm

echo
echo "Building new docker image for tarm based on local TA code"
docker build -t matchbox/tarm ~/git/treatment-arm-api/treatment_arm_api/

echo
echo "Start DB Instance"
docker run -d -v /tmp/mongodb -p 27017:27017 --name mongodb -e MONGODB_DBNAME=match mongo:3.2.4

echo
echo "Start TreatmentArmAPI Instance"
#docker run -d --name TreatmentArm --link mongodb -p 3000:10235 matchbox/treatment-arm-api
docker run -d --name TreatmentArm --link mongodb -p 3000:10235 matchbox/tarm

echo
echo "Loading TAs into DB"
cd ~/git/treatment-arm-api/treatment_arm_api/scripts/treatment_arm_loader/app/
ruby treatment_arm_loader.rb -u http://192.168.99.100:3000/treatmentarm/ -f ../spreadsheets/production/WAVE3_ARMS_FULL_LATEST.xlsx -s eay131_a

echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
