#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-dev-data-agent-493217}"
REGION="${REGION:-us-central1}"
REPOSITORY_ID="${REPOSITORY_ID:-adk-agent-images}"
IMAGE_NAME="${IMAGE_NAME:-event-agent}"
IMAGE_TAG="${IMAGE_TAG:-0.1.0}"

IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet

docker build -t "${IMAGE_URI}" ./agent
docker push "${IMAGE_URI}"

echo "${IMAGE_URI}"