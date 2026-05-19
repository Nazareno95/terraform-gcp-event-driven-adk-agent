#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-dev-data-agent-493217}"
REGION="${REGION:-us-central1}"
REPOSITORY_ID="${REPOSITORY_ID:-adk-agent-images}"
IMAGE_NAME="${IMAGE_NAME:-event-simulator}"
IMAGE_TAG="${IMAGE_TAG:-0.1.0}"

IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "Configuring Docker authentication..."
gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet

echo "Building image: ${IMAGE_URI}"
docker build -t "${IMAGE_URI}" ./simulator

echo "Pushing image: ${IMAGE_URI}"
docker push "${IMAGE_URI}"

echo "Done."
echo "Image URI:"
echo "${IMAGE_URI}"