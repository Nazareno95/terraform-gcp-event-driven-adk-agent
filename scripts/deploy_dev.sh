#!/usr/bin/env bash
set -euo pipefail

cd examples/retail_fraud_detection

terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars -auto-approve