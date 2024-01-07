#!/bin/bash

root_dir=$(pwd)

# # Install Terraform
# echo "Installing Terraform..."
# cd terraform
# terraform init
# terraform plan
# terraform apply -auto-approve

# Trigger Cloud Build
cd "$root_dir"
echo "Triggering Cloud Build..."
gcloud builds submit --config=cloudbuild.yaml .

# # Setup Argo CD Helm Chart
# echo "Setting up Argo CD Helm Chart..."
# kubectl create namespace argo

# helm repo add argo https://argoproj.github.io/argo-helm
# helm install argo argo/argo-cd --version 4.5.0 --values helm/argo-cd/values.yaml -n argo
# kubectl apply -f application.yaml -n argo

echo "Setup complete!"
