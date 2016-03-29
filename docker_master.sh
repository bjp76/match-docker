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
echo
echo "----------Starting MongoDB--------------------------------------------------------------------"
./docker_mongo.sh
echo
echo
echo "----------Starting RabbitMQ-------------------------------------------------------------------"
./docker_rabbitmq.sh
echo
echo
echo "----------Starting TreatmentArmAPI------------------------------------------------------------"
./docker_treatmentarm.sh

# TODO: Offer to load baseline data to DB
echo
echo
echo "Loading TAs into DB"
cd ~/git/treatment-arm-api/treatment_arm_api/scripts/treatment_arm_loader/app/
ruby treatment_arm_loader.rb -u http://192.168.99.100:10235/ -f ../spreadsheets/production/WAVE3_ARMS_FULL_LATEST.xlsx -s eay131_a


echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
