# ADR-0020: DEV Application and Delivery Foundation

## Status

Accepted

## Context

LW-0004.1 established the DEV/POC and PROD account boundaries.

LW-0004.2 established the initial DEV security foundation, including
Terraform account protection, CloudTrail, GuardDuty, state security,
tagging, and the separation of production-only controls.

LW-0004.3 introduces the first application infrastructure while preserving
those boundaries.

DEV must support the complete engineering lifecycle:

- Build.
- Test.
- Deploy.
- Validate.
- Destroy.
- Rebuild.

DEV must remain safe to destroy and recreate because it contains synthetic
data only.

The delivery architecture must support future production promotion without
placing production-only infrastructure or deployment actions into the DEV
workflow.

## Decision

LoanWise will use a common CI/CD architecture with environment-specific
deployment paths.

### Continuous Integration

CI will perform environment-independent checks including:

- Formatting.
- Linting.
- Unit tests.
- Application build.
- Terraform validation.
- Terraform plan generation.
- Security checks.

CI does not deploy production resources.

### DEV Delivery

The DEV deployment workflow will:

1. Authenticate using the approved GitHub Actions OIDC path.
2. Validate Terraform.
3. Generate a Terraform plan.
4. Deploy DEV infrastructure.
5. Deploy the application.
6. Execute smoke/integration validation.
7. Report the result.

### DEV Destroy/Rebuild

DEV will support an explicitly controlled destroy/rebuild workflow.

The workflow will:

1. Confirm the target is DEV.
2. Confirm the AWS account boundary.
3. Destroy DEV infrastructure through Terraform.
4. Verify expected resources are absent.
5. Reinitialize Terraform state as required.
6. Recreate DEV infrastructure.
7. Deploy the application.
8. Recreate synthetic identities/data.
9. Execute automated validation.
10. Record the result.

Production must never be targeted by the DEV destroy workflow.

The DEV destroy/rebuild workflow is independently authorized and is not
part of the normal DEV deployment workflow.

### PROD Delivery

Production deployment will use the same general CI/CD foundation but a
separate protected environment and AWS account.

Production-only controls, approvals, security services, data protection,
and deployment safeguards will be added to the PROD path.

The DEV workflow must not contain production deployment actions.

## Infrastructure Boundary

The initial DEV application architecture will use:

- Cognito.
- API Gateway.
- Lambda.
- DynamoDB.
- Application S3.
- CloudFront.
- Application/service IAM roles.
- CloudWatch logs and alarms where meaningful.

Exact resource inventory and implementation details are defined by the
LW-0004.3 architecture and subsequent work items.

## Identity Boundary

Human AWS administration remains through IAM Identity Center.

Application users authenticate through Cognito.

GitHub Actions uses OIDC and environment-specific deployment roles.

Lambda and other AWS services use dedicated execution roles.

These identity types remain separate.

## Terraform Boundary

Environment roots remain:

- `infrastructure/environments/dev/`
- `infrastructure/environments/prod/`

Reusable implementation remains under:

- `infrastructure/modules/`

DEV and PROD state remain isolated.

The DEV provider account boundary remains mandatory.

## Consequences

This approach:

- Makes DEV fully rebuildable.
- Provides a realistic engineering lifecycle before production exists.
- Prevents production deployment logic from being mixed into DEV.
- Establishes the delivery model before application infrastructure expands.
- Enables later production promotion using the same CI/CD foundation.

## Deferred Items

The following remain outside LW-0004.3 DEV implementation:

- Production account deployment.
- Production customer data.
- Production DNS cutover.
- Final production WAF implementation.
- Final production backup/DR implementation.
- Full production approval workflow.
