# Amazon Elastic Kubernetes Service (EKS) Module

## Overview

This module provisions a production-ready Amazon EKS cluster.

The module creates:

- Amazon EKS Cluster
- Managed Node Groups
- Launch Templates
- Security Groups
- IAM Roles
- OIDC Provider
- IRSA Roles
- KMS Encryption
- Control Plane Logging
- CloudWatch Monitoring
- EKS Add-ons

---

## Features

- Private Cluster
- Managed Node Groups
- IAM Roles
- OIDC Authentication
- IAM Roles for Service Accounts (IRSA)
- KMS Secrets Encryption
- CloudWatch Logging
- Core AWS Add-ons
- Common Tagging

---

## Resources Created

- aws_eks_cluster
- aws_eks_node_group
- aws_launch_template
- aws_security_group
- aws_iam_role
- aws_cloudwatch_log_group
- aws_eks_addon

---

## Dependencies

This module consumes outputs from:

- Foundation VPC
- Foundation IAM
- Foundation KMS
- Foundation Secrets Manager

---

## Inputs

- Cluster Name
- Kubernetes Version
- VPC ID
- Private Subnets
- Node Group Configuration
- KMS Key ARN
- Tags

---

## Outputs

- Cluster Name
- Cluster ARN
- Cluster Endpoint
- OIDC Provider
- Node Group Names
- Security Group IDs
