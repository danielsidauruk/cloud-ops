#!/bin/bash

# Script to deploy infrastructure, trigger Cloud Build, and set up Argo CD Helm Chart

# Set root directory
root_dir=$(pwd)

# Function to display a header
header() {
  echo "====================================="
  echo "$1"
  echo "====================================="
}

# # Install Terraform
# header "Installing Terraform"
# cd terraform
# terraform init
# terraform apply -auto-approve

# Trigger Cloud Build
cd "$root_dir"
header "Triggering Cloud Build"
gcloud builds submit --config=cloudbuild.yaml .

# Setup Argo CD Helm Chart
header "Setting up Argo CD Helm Chart"
# Don't forget to set the context to gke-context
gcloud container clusters get-credentials gke-cluster --zone us-central1-a --project cloud-ops-44
kubectl create namespace argo
helm repo add argo https://argoproj.github.io/argo-helm
helm install argo argo/argo-cd --version 4.5.0 --values helm/argo-cd/values.yaml -n argo
kubectl apply -f helm/argo-cd/application.yaml -n argo

# Retrieve the LoadBalancer IP
header "Retrieving LoadBalancer IP"
SERVICE_IP=$(kubectl get svc pyapp -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
SERVICE_PORT=$(kubectl get svc pyapp -o jsonpath='{.spec.ports[0].port}')
echo "Application URL: http://${SERVICE_IP}:${SERVICE_PORT}"

# Display completion message
header "Setup complete!"
