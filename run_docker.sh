#!/usr/bin/env bash

## Complete the following steps to get Docker running locally
DOCKERHUB_ID="razorbreak"
PROJECT_NAME="ml-microservice-kubernetes"
PROJECT_VERSION="1.0.0"

# Step 1:
# Build image and add a descriptive tag
docker build --tag ${DOCKERHUB_ID}/${PROJECT_NAME}:${PROJECT_VERSION} .

# Step 2: 
# List docker images
docker images

# Step 3: 
# Run flask app
docker run -p 8000:80 --name ${PROJECT_NAME} ${DOCKERHUB_ID}/${PROJECT_NAME}:${PROJECT_VERSION}
docker rm ${PROJECT_NAME}
