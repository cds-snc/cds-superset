#!/bin/bash

# Script to run Superset database upgrade task on ECS
# Usage: ./run-superset-upgrade.sh <cluster> <subnets> <security_group_id>

set -e

# Check if all required arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <cluster> <subnets> <security_group_id>"
    echo "  cluster: ECS cluster name"
    echo "  subnets: Comma-separated list of subnet IDs"
    echo "  security_group_id: Security group ID for the task"
    exit 1
fi

CLUSTER="$1"
SUBNETS="$2"
SECURITY_GROUP_ID="$3"

echo "Running Superset database upgrade..."

# Run the ECS task
TASK_ARN=$(aws ecs run-task \
    --cluster "$CLUSTER" \
    --task-definition superset-upgrade \
    --launch-type FARGATE \
    --count 1 \
    --network-configuration "awsvpcConfiguration={subnets=[$SUBNETS],securityGroups=[$SECURITY_GROUP_ID],assignPublicIp=DISABLED}" \
    --query 'tasks[0].taskArn' \
    --output text)

echo "Started task: $TASK_ARN"
echo "Waiting for task to complete..."

# Wait for the task to stop
aws ecs wait tasks-stopped \
    --cluster "$CLUSTER" \
    --tasks "$TASK_ARN"

# Check if the task completed successfully
EXIT_CODE=$(aws ecs describe-tasks \
    --cluster "$CLUSTER" \
    --tasks "$TASK_ARN" \
    --query 'tasks[0].containers[0].exitCode' \
    --output text)

if [ "$EXIT_CODE" != "0" ]; then
    echo "Database upgrade task failed with exit code: $EXIT_CODE"
    exit 1
fi

echo "Database upgrade completed successfully"
