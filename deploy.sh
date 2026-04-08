#!/bin/bash
set -e

DOCKER_USER="vickyneduncheziyan"
BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "=============================="
echo " Deploying Application"
echo " Branch: $BRANCH"
echo "=============================="

if [ "$BRANCH" = "master" ] || [ "$BRANCH" = "main" ]; then
  REPO="prod"
else
  REPO="dev"
fi

IMAGE_TAG="$DOCKER_USER/$REPO:latest"

echo "Pulling image: $IMAGE_TAG"
docker pull "$IMAGE_TAG"

echo "Stopping existing container (if any)..."
docker stop devops-app 2>/dev/null || true
docker rm devops-app 2>/dev/null || true

echo "Starting new container..."
docker run -d \
  --name devops-app \
  --restart always \
  -p 80:80 \
  "$IMAGE_TAG"

echo "=============================="
echo " Deployment Complete!"
echo " App running at http://$(curl -s ifconfig.me)"
echo "=============================="
