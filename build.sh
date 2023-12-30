#!/bin/bash

IMAGE_NAME="afl-stats"

# Build the Docker image
docker build -t $IMAGE_NAME .