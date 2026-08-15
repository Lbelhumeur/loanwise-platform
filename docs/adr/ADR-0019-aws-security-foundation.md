# ADR-0019: AWS Security Foundation Strategy

## Status

Accepted

## Context

LW-0004.1 established the LoanWise AWS account and environment foundation:

- DEV uses the existing AWS account.
- PROD will use a dedicated AWS account.
- Terraform enforces environment account boundaries.
- Terraform state is stored remotely in Amazon S3.
- Production infrastructure must not be deployed into the DEV account.
- Account IDs and credentials must not be stored in source control.

LW-0004.2 establishes the security foundation that will support those
environment boundaries.

The security model must distinguish between controls that can be implemented
now in DEV and controls that require the future dedicated PROD account.

## Decision

LoanWise will use a layered AWS security model with separate implementation
boundaries for DEV and PROD.

### DEV

The DEV account will implement the security controls required for safe
development and infrastructure administration, including:

- IAM Identity Center administrative access.
- Terraform AWS account boundary enforcement.
- Secure Terraform state storage.
- Required resource tagging.
- CloudTrail and audit logging requirements.
- CloudWatch monitoring requirements.
- Secrets Manager usage boundaries.
- KMS requirements where encryption keys are required.
- Appropriate AWS security-service controls for the DEV/POC environment.

DEV will use synthetic/non-production data and will not be treated as the
production security boundary.

### PROD

The future dedicated PROD account will receive the production security
baseline when that account is available.

The production baseline will include requirements for:

- WAF.
- KMS.
- Secrets Manager.
- CloudTrail and centralized audit logging.
- CloudWatch monitoring.
- GuardDuty.
- Inspector.
- Security Hub.
- AWS Config controls.
- Production data protection.
- Backup and recovery controls.

Production security resources must not be implemented in the DEV account
merely to satisfy the production design requirements.

## Terraform Boundaries

Security resources will be implemented through Terraform modules rather than
placing reusable security resources directly into environment root modules.

Environment-specific configuration remains under:

- `infrastructure/environments/dev/`
- `infrastructure/environments/prod/`

Reusable security implementation belongs under:

- `infrastructure/modules/security/`

The existing Terraform state bootstrap remains under:

- `infrastructure/bootstrap/state/`

## Account Safety

Terraform providers must continue to use `allowed_account_ids` so an
environment cannot silently deploy into an unintended AWS account.

Account IDs and credentials are supplied through local/runtime configuration
and must not be committed to source control.

## Consequences

This approach:

- Keeps DEV and PROD security boundaries explicit.
- Prevents production-only services from being accidentally deployed to DEV.
- Provides reusable Terraform security components.
- Allows the production security baseline to be implemented after the
  dedicated PROD account becomes available.
- Keeps security implementation reviewable and independently deployable.

## Deferred Items

The following remain deferred until the dedicated PROD account and
corresponding production implementation work are available:

- Production WAF deployment.
- Production KMS implementation.
- Production GuardDuty/Inspector/Security Hub deployment.
- Production centralized logging.
- Production data-protection implementation.
- Production backup and recovery implementation.
