#!/usr/bin/env bash

docker build -t sgupdate:latest .
docker tag sgupdate:latest ${aws_access_key_id}.dkr.ecr.${default_region}.amazonaws.com/sgupdate:latest
docker push ${aws_access_key_id}.dkr.ecr.${default_region}.amazonaws.com/sgupdate:latest
