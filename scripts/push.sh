#!/usr/bin/env bash

set -euo pipefail

AWS_ACCOUNT_ID=$1
REGION=$2
CONTAINER=$3
ENV=$4
TAG=$5


IMAGE="${CONTAINER}:${TAG}"
REPOSITORY="${ECR_REPOSITORY_URL}:${TAG}"

echo "retagging image ${IMAGE} for registry ${REPOSITORY}"
docker tag "${IMAGE}" "${REPOSITORY}"
echo "pushing $REPOSITORY ..."
docker push "$REPOSITORY"
