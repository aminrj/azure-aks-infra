# Kubernetes Infrastructure with GitOps and Terraform

This project sets up a Kubernetes infrastructure with GitOps using Terraform.

## Overview

This project aims to provide a robust and scalable infrastructure for deploying Kubernetes. It leverages the GitOps methodology for continuous deployment and Terraform for infrastructure as code and to orchestrate the infrastructure.

## Features

- **Kubernetes Deployment**: This project allows for easy deployment of Kubernetes clusters.
- **GitOps Setup**: It uses the GitOps methodology, which uses a version control system for all changes to the system.
- **Terraform**: Infrastructure is managed using Terraform, which allows for easy scaling and management.

## Getting Started

To get started with this project, you'll need to have Terraform and Kubernetes installed on your machine.

1. Clone this repository
2. Navigate to the project directory
3. Run `terraform init` to initialize your Terraform workspace
4. Run `terraform apply` to create the infrastructure
5. Once Terraform finish deploying, run `az aks get-credentials --resource-group aks-poc --name my-aks-cluster --admin` to setup the kubeconfig and start using `kubectl`
6. Test with `kubectl get nodes`

## Test ingress setup

The External-DNS service is deployed to the cluster and should pick-up any ingress created to update AzureDNS service with new domain records.
To test the ingress setup, follow these steps:
1. Run `kubectl apply -f k8s/ingress-example`
2. Run `kubectl get ingress` to check the loadbalancer is created with a public-ip
3. Wait for the domain to be provisionned on AzureDNS
4. Navigate to the domain and check