#!/bin/bash

echo
echo
echo "----------Starting TreatmentArmAPI--------------------------------------------------------------------"
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

#echo 
#read -p "Rebuild Docker image from latest code in ~/git/treatment-arm-api/treatment_arm_api? (y/n)" -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
    #docker build -t matchbox/tarm ~/git/treatment-arm-api/treatment_arm_api/
#fi

echo
echo "Start TreatmentArmAPI Instance"
docker pull matchbox/nci-treatment-arm-api:latest
docker run -d --name TreatmentArmApi --link mongodb --link rabbitmq -p 10235:10235 matchbox/nci-treatment-arm-api:latest

echo
echo "Start TreatmentArmProcessorAPI Instance"
docker pull matchbox/nci-treatment-arm-processor-api:latest
docker run -d --name TreatmentArmProcessorApi --link mongodb --link rabbitmq -p 3000:3000 matchbox/nci-treatment-arm-processor-api:latest

#Offer to load baseline data to DB
#echo
#echo
#read -p "Load TAs into DB? (y/n)" -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
   #cd ~/git/treatment-arm-api/treatment_arm_api/scripts/treatment_arm_loader/app/
   #ruby treatment_arm_loader.rb -u http://192.168.99.100:10235/ -f ../spreadsheets/production/WAVE3_ARMS_FULL_LATEST.xlsx -s eay131_a
#fi


echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
