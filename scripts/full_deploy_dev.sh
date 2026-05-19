#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-dev-data-agent-493217}"
REGION="${REGION:-us-central1}"
REPOSITORY_ID="${REPOSITORY_ID:-adk-agent-images}"
IMAGE_NAME="${IMAGE_NAME:-event-simulator}"
IMAGE_TAG="${IMAGE_TAG:-0.1.0}"

IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "Deploying Terraform infrastructure..."

cd examples/retail_fraud_detection

terraform init
terraform fmt -recursive
terraform validate
terraform apply -var-file=dev.tfvars -auto-approve

cd ../..

echo "Building and pushing simulator image..."

gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet
docker build -t "${IMAGE_URI}" ./simulator
docker push "${IMAGE_URI}"

echo "Updating Cloud Run service with image..."

cd examples/retail_fraud_detection

terraform apply \
  -var-file=dev.tfvars \
  -var="simulator_image=${IMAGE_URI}" \
  -auto-approve

echo "Deployment completed."
echo "Simulator image: ${IMAGE_URI}"
terraform output simulator_service_uri