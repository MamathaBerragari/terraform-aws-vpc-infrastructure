# Karpenter Module

## Overview

This module deploys Karpenter on an existing Amazon EKS cluster.

Karpenter automatically provisions and terminates EC2 instances based on Kubernetes pod scheduling requirements.

## Features

- IAM Role for Service Account (IRSA)
- SQS interruption queue
- Helm deployment
- EC2NodeClass
- NodePool
- Spot and On-Demand support
- Production-ready configuration

## Dependencies

- EKS Cluster
- OIDC Provider
- IAM
- VPC
- Private Subnets
