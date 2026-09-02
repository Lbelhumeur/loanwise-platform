# Infrastructure

Terraform is the source of truth.

Environments: dev, prod.

DEV is the development and POC environment and uses synthetic data only.

Production is deployed into a dedicated AWS account and contains real customer data.

## GitHub Actions DEV Backend

Local development may use an ignored `backend.hcl` file. The DEV deployment
workflow must not depend on that file: it derives the state-bucket name from
the approved `AWS_ACCOUNT_ID` GitHub environment variable and configures the
Terraform backend at runtime. The account ID is passed to the DEV Terraform
plan at runtime and is never committed as a Terraform variable value.
