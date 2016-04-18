#!/bin/bash

echo
echo
echo "----------Starting MongoDB--------------------------------------------------------------------"
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
docker pull mongo:3.2.4

echo
echo "Start DB Instance"
mkdir -p /tmp/mongodb
docker run -d -v /tmp/mongodb -p 27017:27017 --name mongodb -e MONGODB_DBNAME=match mongo:3.2.4 
#docker run -d -v /tmp/mongodb -p 27017:27017 --name mongodb -e MONGODB_DBNAME=match mongo:3.2.4 --auth
#docker run -d -v ~/git/match-docker/Dockerfiles/mongodb:/mongodb -p 27017:27017 --name mongodb mongo:3.2.4 -f /mongodb/mongod.conf --auth

#docker run -it --link mongodb --rm mongo sh -c 'mongo --host 192.168.99.100 --port 27017 --eval "db.hostInfo()"'
#docker run -it --link mongodb --rm mongo sh -c 'mongo --host 192.168.99.100 --port 27017 --eval "db.createUser({ user: \"root\", pwd: \"M@tch123\", roles: [ { role: \"root\", db: \"admin\" } ] });"'
#docker run -it --link mongodb --rm mongo sh -c 'mongo --host 192.168.99.100 --port 27017 --eval "db.createUser({ user: \"match\", pwd: \"M@tch123\", roles: [ { role: \"dbOwner\", db: \"Match\" } ] });"'

#docker exec mongodb mongo admin --eval 'db.createUser({ user: "root", pwd: "M@tch123", roles: [ { role: "root", db: "admin" } ] });'
#docker exec mongodb mongo -u root -p M@tch123 admin --eval 'db.createUser({ user: "match", pwd: "M@tch123", roles: [ { role: "dbOwner", db: "Match" } ] });'
#docker exec mongodb mongo -u root -p M@tch123 admin --eval 'db.hostInfo();'

echo
echo "Local Docker Machine IP"
docker-machine ip default

echo
echo "Docker Containers:"
docker ps -a
