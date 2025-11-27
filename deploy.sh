#!/bin/bash
# Deployment script for Flask app

set -e

echo "Starting deployment process..."

# Pull the latest Docker image
docker pull $DOCKER_REGISTRY/$IMAGE_NAME:$BUILD_ID

# Stop and remove existing container if it exists
echo "Stopping existing container..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Run new container
echo "Starting new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p 5000:5000 \
  -e FLASK_ENV=production \
  $DOCKER_REGISTRY/$IMAGE_NAME:$BUILD_ID

echo "Deployment completed successfully!"
