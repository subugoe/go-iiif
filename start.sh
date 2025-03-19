#!/bin/sh


docker compose stop  go-iiif 
docker compose rm -f  go-iiif 
docker compose up -d go-iiif 
#docker compose up -d --build go-iiif 
#COMPOSE_BAKE=true docker compose up -d --build go-iiif 
