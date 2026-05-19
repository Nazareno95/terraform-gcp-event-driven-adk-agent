#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-dev-data-agent-493217}"
REGION="${REGION:-us-central1}"
REPOSITORY_ID="${REPOSITORY_ID:-adk-agent-images}"

SIMULATOR_IMAGE_NAME="${SIMULATOR_IMAGE_NAME:-event-simulator}"
AGENT_IMAGE_NAME="${AGENT_IMAGE_NAME:-event-agent}"
IMAGE_TAG="${IMAGE_TAG:-0.1.0}"

SIMULATOR_IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY_ID}/${SIMULATOR_IMAGE_NAME}:${IMAGE_TAG}"
AGENT_IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY_ID}/${AGENT_IMAGE_NAME}:${IMAGE_TAG}"

echo "Deploying base infrastructure..."
cd examples/retail_fraud_detection

terraform init
terraform fmt -recursive
terraform validate
terraform apply -var-file=dev.tfvars -auto-approve

cd ../..

echo "Configuring Docker authentication..."
gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet

echo "Building simulator image..."
docker build -t "${SIMULATOR_IMAGE_URI}" ./simulator
docker push "${SIMULATOR_IMAGE_URI}"

echo "Building agent image..."
docker build -t "${AGENT_IMAGE_URI}" ./agent
docker push "${AGENT_IMAGE_URI}"

echo "Deploying Cloud Run services with real images..."
cd examples/retail_fraud_detection

terraform apply \
  -var-file=dev.tfvars \
  -var="simulator_image=${SIMULATOR_IMAGE_URI}" \
  -var="agent_image=${AGENT_IMAGE_URI}" \
  -auto-approve

echo "Deployment completed."
echo "Simulator URI:"
terraform output simulator_service_uri

echo "Agent URI:"
terraform output agent_service_uri