#!/bin/bash
eval "$(direnv hook bash)"

# load environment variables
direnv allow .

#start docker services
docker compose up --build