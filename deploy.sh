#!/bin/bash

docker build -t panchem/woodshop .

docker stop woodshop
docker rm woodshop

docker run \
    --name woodshop \
    -d \
    -p 3000:3000 \
    -e VIRTUAL_PORT=3000 \
    -e VIRTUAL_HOST="wood.piikl.com" \
    -e LETSENCRYPT_HOST="wood.piikl.com" \
    -e LETSENCRYPT_EMAIL="info@piikl.com" \
    panchem/woodshop
