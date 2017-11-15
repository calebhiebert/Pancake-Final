#!/bin/bash

docker build -t panchem/woodshop-frontend .

docker stop woodshop-frontend
docker rm woodshop-frontend

docker run \
    --name woodshop-frontend \
    -d \
    -p 8082:80 \
    -e VIRTUAL_PORT=80 \
    -e VIRTUAL_HOST="woodshop.piikl.com" \
    -e LETSENCRYPT_HOST="woodshop.piikl.com" \
    -e LETSENCRYPT_EMAIL="info@piikl.com" \
    panchem/woodshop-frontend
