#!/bin/bash
set -e

DOCKER_USER="vickyneduncheziyan"
BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "=============================="
echo " Building Docker Image"
echo " Branch: $BRANCH"
echo "=============================="

if [ "$BRANCH" = "master" ] || [ "$BRANCH" = "main" ]; then
  REPO="prod"
else
  REPO="dev"
fi

IMAGE_TAG="$DOCKER_USER/$REPO:latest"

echo "Building image: $IMAGE_TAG"
docker build -t "$IMAGE_TAG" .

echo "=============================="
echo " Build Complete: $IMAGE_TAG"
echo "=============================="
