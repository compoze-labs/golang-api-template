#!/usr/bin/env bash

set -euo pipefail

AWS_ACCOUNT_ID=$1
REGION=$2
CONTAINER=$3
ENV=$4
TAG=$5

ENV_CONTAINER="${ENV}/${CONTAINER}"

docker tag "${CONTAINER}":"${TAG}" "${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${ENV_CONTAINER}:latest"
docker push "${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${ENV_CONTAINER}:latest"
