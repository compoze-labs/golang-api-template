#!/usr/bin/env bash

set -euo pipefail

SERVICE=$1
STAGE=$2

output=$(aws ecs update-service --cluster ${SERVICE}-${STAGE} --service "${SERVICE}-${STAGE}" --force-new-deployment 2>&1)
echo "${output}" | jq ".service.taskDefinition"

echo "waiting for deployment to become stable"
aws ecs wait services-stable --cluster "${SERVICE}-${STAGE}" --service "${SERVICE}-${STAGE}"
