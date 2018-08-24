#!/bin/bash

container=$1

if [ -z $container ]
then
   echo "First argument should be the container's name"
   exit
fi

sudo docker stop $container
sudo docker rm $container 

sudo docker run -dit --name=$container -p 0.0.0.0:818:818 -p 0.0.0.0:4004:4004 -p 127.0.0.1:8080:8080 -p 127.0.0.1:8800:8800 sameerfarooq/sparts-test:latest /project/sparts_ledger.sh

sleep 30s
curl -i http://0.0.0.0:818/ledger/api/v1/ping

## Need to initialize the very first user (only one time via register_init command).
sudo docker exec -ti latest sh -c "user register_init 02be88bd24003b714a731566e45d24bf68f89ede629ae6f0aa5ce33baddc2a0515 johndoe john.doe@windriver.com allow admin"

