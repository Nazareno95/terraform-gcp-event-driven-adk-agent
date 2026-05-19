## Architecture

BigQuery → Pub/Sub → ADK Agent → BigQuery Audit Logs

## Prerequisites

- Terraform >= 1.6
- Google Cloud SDK
- GCP Project
- Application Default Credentials

## Quickstart

```bash
gcloud auth application-default login
cd examples/retail_fraud_detection
cp dev.tfvars.example dev.tfvars
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars