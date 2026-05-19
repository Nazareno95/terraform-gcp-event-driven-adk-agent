# terraform-gcp-event-driven-adk-agent

Production-ready Terraform blueprint for deploying event-driven AI agents on Google Cloud using BigQuery, Pub/Sub, Cloud Run, and Vertex AI Agent patterns.

---

# Overview

This project provides a reusable Infrastructure as Code (IaC) foundation for building event-driven AI agent architectures on Google Cloud Platform.

The solution is inspired by Google's Event-Driven Agent architecture and extends it with:

* Terraform modularization
* Reusable infrastructure modules
* Production-ready IAM practices
* Cloud Run based services
* BigQuery observability
* Pub/Sub event-driven processing
* CI/CD validation workflows
* Artifact Registry integration
* Metrics and audit logging

---

# Architecture

```text
                        +----------------------+
                        |   Event Simulator    |
                        |   Cloud Run Service  |
                        +----------+-----------+
                                   |
                                   | Publish Events
                                   v
                        +----------------------+
                        |      Pub/Sub Topic   |
                        |   Event Streaming    |
                        +----------+-----------+
                                   |
                                   | Push Subscription
                                   v
                        +----------------------+
                        |    Agent Consumer    |
                        |   Cloud Run Service  |
                        +----------+-----------+
                                   |
                 +-----------------+-----------------+
                 |                                   |
                 |                                   |
                 v                                   v
      +----------------------+          +----------------------+
      |  BigQuery Audit Log  |          |  BigQuery Metrics    |
      |  agent_audit_log     |          |   agent_metrics      |
      +----------------------+          +----------------------+

```

---

# High-Level Architecture

## Components

### Event Simulator

A Python-based Cloud Run service responsible for generating synthetic transaction events and publishing them to Pub/Sub.

### Pub/Sub

Acts as the event bus and decouples producers from consumers.

### Agent Consumer

Cloud Run service that:

* Receives Pub/Sub push events
* Processes transaction payloads
* Applies business logic
* Writes audit logs to BigQuery
* Tracks metrics and latency

### BigQuery

Provides:

* Transaction storage
* Audit logging
* Metrics tracking
* Analytics capabilities
* Observability layer

### Artifact Registry

Stores container images for:

* Simulator
* Agent consumer

---

# Repository Structure

```text
terraform-gcp-event-driven-adk-agent/
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── examples/
│   └── retail_fraud_detection/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── dev.tfvars
│       └── dev.tfvars.example
│
├── modules/
│   ├── apis/
│   ├── artifact_registry/
│   ├── bigquery/
│   ├── cloud_run_agent/
│   ├── cloud_run_simulator/
│   ├── iam/
│   ├── observability/
│   └── pubsub/
│
├── simulator/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── agent/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── scripts/
│   ├── build_and_push_agent.sh
│   ├── build_and_push_simulator.sh
│   ├── deploy_dev.sh
│   ├── full_deploy_dev.sh
│   ├── render_continuous_query.sh
│   └── apply_continuous_query.sh
│
├── sql/
│   └── continuous_queries/
│       └── transaction_events.sql
│
├── .gitignore
├── README.md
└── versions.tf
```

---

# Features

* Modular Terraform architecture
* BigQuery datasets and tables
* Pub/Sub topics and subscriptions
* Push subscriptions to Cloud Run
* Artifact Registry deployment
* Cloud Run services
* Event-driven processing
* Audit logging
* Metrics collection
* Observability tables
* CI/CD validation
* Infrastructure automation scripts
* Least privilege IAM

---

# Prerequisites

## Required Software

* Terraform >= 1.6
* Google Cloud SDK
* Docker
* Git

## Required GCP APIs

The project automatically enables:

* BigQuery API
* Pub/Sub API
* Cloud Run API
* Artifact Registry API
* IAM API
* Vertex AI API

---

# Authentication

## Login

```bash
gcloud auth login
```

## Configure Application Default Credentials

```bash
gcloud auth application-default login
```

## Configure Project

```bash
gcloud config set project YOUR_PROJECT_ID
```

---

# Quick Start

## Clone Repository

```bash
git clone https://github.com/Nazareno95/terraform-gcp-event-driven-adk-agent.git
cd terraform-gcp-event-driven-adk-agent
```

## Configure Variables

```bash
cd examples/retail_fraud_detection
cp dev.tfvars.example dev.tfvars
```

Update:

```hcl
project_id = "YOUR_PROJECT_ID"
```

## Deploy Infrastructure

```bash
./scripts/full_deploy_dev.sh
```

---

# Terraform Modules

## apis

Enables required Google Cloud APIs.

## artifact_registry

Creates Docker Artifact Registry repositories.

## bigquery

Creates:

* datasets
* transaction tables
* audit log tables

## cloud_run_simulator

Deploys simulator Cloud Run service.

## cloud_run_agent

Deploys event-driven AI agent consumer.

## pubsub

Creates:

* topics
* subscriptions
* push subscriptions

## observability

Creates metrics and monitoring tables.

## iam

Manages service accounts and least privilege IAM roles.

---

# Event Flow

```text
1. Simulator generates transaction event
2. Event published to Pub/Sub topic
3. Push subscription forwards event to Agent
4. Agent processes transaction
5. Agent writes audit logs to BigQuery
6. Agent stores metrics and latency
```

---

# BigQuery Tables

## transactions

Stores transaction events.

## agent_audit_log

Stores:

* agent decisions
* processed payloads
* timestamps

## agent_metrics

Stores:

* processing metrics
* latency metrics
* high-risk event counts

---

# Security Best Practices

This project follows:

* Least privilege IAM
* Service account isolation
* Cloud-native authentication
* Push subscription OIDC tokens
* Environment-based deployment

---

# Observability

The solution includes:

* Audit logging
* Metrics collection
* Processing latency tracking
* High-risk event monitoring
* BigQuery analytics

---

# CI/CD

GitHub Actions pipeline validates:

* Terraform formatting
* Terraform validation
* Terraform initialization

Future roadmap:

* tflint
* checkov
* terraform-docs
* pre-commit hooks
* security scanning

---

# Example Queries

## Latest Audit Logs

```sql
SELECT *
FROM `YOUR_PROJECT.retail_fraud_agent_dev.agent_audit_log`
ORDER BY created_at DESC
LIMIT 10;
```

## Metrics Dashboard Query

```sql
SELECT
  DATE(metric_timestamp) AS metric_date,
  SUM(events_processed) AS total_events,
  SUM(high_risk_events) AS risky_events,
  AVG(processing_latency_ms) AS avg_latency
FROM `YOUR_PROJECT.retail_fraud_agent_dev.agent_metrics`
GROUP BY metric_date
ORDER BY metric_date DESC;
```

---

# Roadmap

## v0.1

* Terraform base infrastructure
* BigQuery
* Pub/Sub
* IAM

## v0.2

* Cloud Run simulator
* Artifact Registry
* Full deployment scripts

## v0.3

* Event-driven agent consumer
* Observability
* Metrics

## v0.4

* BigQuery Continuous Queries
* Vertex AI Agent integration
* Gemini integration

## v1.0

* Production-ready blueprint
* Multi-environment deployment
* Security hardening
* Monitoring dashboards
* Terraform Registry publication

---

# Future Enhancements

* Vertex AI Agent Engine
* Gemini-powered decisioning
* Databricks integration
* Delta Lake integration
* Advanced monitoring dashboards
* Multi-region deployments
* Terraform Cloud support
* Kubernetes deployment options

---

# Contributing

Contributions are welcome.

Potential contribution areas:

* Additional Terraform modules
* Observability improvements
* Security enhancements
* AI integrations
* Documentation
* Testing

---

# License

MIT License

---

# Author

Nazareno Medrano Villavicencio

---

# References

* Google Cloud Pub/Sub
* Google BigQuery
* Google Cloud Run
* Google Artifact Registry
* Terraform Google Provider
* Google Event-Driven Agent Architecture
