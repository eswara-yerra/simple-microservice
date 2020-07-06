#!/bin/bash
OPERATION=$1
ENV=$2
MODULE=$3
REGION=$4

cd modules/${MODULE}

terraform init -backend-config="bucket=stream-tweets" -backend-config="key=${MODULE}/terraform.tfstate" -backend-config="region=${REGION}"
terraform plan -var-file="env/${ENV}.tfvars"
terraform apply --auto-approve -var-file="env/${ENV}.tfvars"
