#!/bin/bash


docker ps -a
echo
read -p "Stop & Delete ALL containers above? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

containerlist=`docker ps -a -q`

for id in $containerlist
do
docker stop $id
docker rm $id
done

echo
docker ps -a

