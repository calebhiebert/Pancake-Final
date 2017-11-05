#!/bin/bash

cd /home/panchem/Pancake-Final
git pull

docker build -t panchem/woodshop .

docker stop woodshop
docker rm woodshop

docker run \
    --name woodshop \
    -d \
    -e VIRTUAL_PORT=3000 \
    -e VIRTUAL_HOST="wood.piikl.com" \
    -e LETSENCRYPT_HOST="wood.piikl.com" \
    -e LETSENCRYPT_EMAIL="info@piikl.com" \
    panchem/woodshop
