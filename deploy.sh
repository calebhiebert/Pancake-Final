#!/bin/bash

cd /home/panchem/Pancake-Final
git pull

docker build -t panchem/woodshop .

docker stop woodshop
docker rm woodshop

docker run \
    --name woodshop \
    -p 3000:3000 \
    -d \
    panchem/woodshop
