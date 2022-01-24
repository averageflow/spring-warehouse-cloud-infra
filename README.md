# spring-warehouse-cloud-infra

Learn how to combine Terraform with CloudSQL (Postgres), Google Kubernetes Engine and VPC. The infrastructure defined here aims to support the [Spring Warehouse application](https://github.com/averageflow/spring-warehouse).

### Learn Terraform - Provision a GKE Cluster

This repo is a companion repo to the [Provision a GKE Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-gke-cluster), containing Terraform configuration files to provision an GKE cluster on GCP.

This sample repo also creates a VPC and subnet for the GKE cluster. This is not
required but highly recommended to keep your GKE cluster isolated.
