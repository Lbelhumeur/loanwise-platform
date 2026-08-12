# ADR-0018: AWS Account and Environment Strategy

- **Status:** Accepted
- **Date:** 2026-08-12
- **Decision:** Maintain two functional LoanWise environments: DEV/POC
  and PROD.
- **Related Work:** LW-0004 AWS Foundation; LW-0004.1 AWS Account &
  Environment Foundation

## Context

LoanWise is initially expected to support approximately 100 students, 1
teacher, and 2 administrators. Development is performed by a small team,
initially centered on a single developer/administrator.

The platform requires strong separation between development activity and
real customer data, while avoiding unnecessary permanent infrastructure
and operational complexity.

The development environment must also be useful for proof-of-concept
work, integration testing, security testing, and infrastructure rebuild
exercises.

Production requires a stronger isolation boundary because it will
contain real customer data and accept external access.

## Decision

LoanWise will use two functional environments:

1.  **DEV / POC**
    - Hosted in the existing AWS account.
    - Used for development, POCs, integration testing, security
      testing, and infrastructure rebuild testing.
    - Contains synthetic data only.
    - Initially contains one developer/administrator and one synthetic
      test user.
    - Must be fully Terraform-managed and safe to destroy and
      recreate.
    - Should be production-representative at the architectural level.
2.  **PROD**
    - Hosted in a dedicated AWS account.
    - Contains all real customer data and production identities.
    - Accepts external customer access.
    - Uses the full production security, monitoring, backup, and
      recovery baseline.
    - Production infrastructure is reproducible through Terraform and
      controlled deployment automation.

This two-environment model is the approved initial operating architecture.

## Environment Boundary

The AWS account boundary is a security and operational boundary:

```text
LoanWise
│
├── DEV / POC
│   └── Existing AWS Account
│       ├── Developer/Admin
│       ├── Synthetic test users
│       └── No production data
│
└── PROD
    └── Dedicated AWS Account
        ├── 100 Students
        ├── 1 Teacher
        ├── 2 Administrators
        └── Real production data
```

## Security Principles

- Human users, application identities, and infrastructure/service
  roles remain separate.
- Production access is more restrictive than DEV access.
- Production secrets are never committed to Git or embedded in
  Terraform variables.
- Production data must never be copied into DEV.
- DEV may be destroyed and recreated without customer-impact risk.
- Production data is protected independently of infrastructure
  lifecycle.
- Production-facing traffic is protected by the approved web and
  security controls.

## Disaster Recovery Principle

The governing principle is:

> **Infrastructure is reproducible; production data is protected.**

DEV provides a low-risk infrastructure recovery exercise:

```text
Terraform destroy
       ↓
Empty DEV
       ↓
Terraform apply
       ↓
Deploy application
       ↓
Load synthetic data
       ↓
Validate
```

Production recovery is tested without casually destroying the
authoritative production environment:

```text
Protected PROD data
       ↓
Backup / PITR / versioned recovery source
       ↓
Isolated recovery target
       ↓
Rebuild infrastructure from Terraform
       ↓
Restore a protected COPY of production data
       ↓
Validate application and data integrity
       ↓
Measure RTO / RPO
       ↓
Destroy recovery target
```

## Consequences

### Positive

- Strong production isolation.
- No production data in development.
- Lower recurring infrastructure cost and operational complexity.
- DEV can be used as a true engineering and POC environment.
- Infrastructure rebuildability becomes testable.
- Production DR can be tested without putting authoritative customer
  data at risk.
- The two-environment architecture provides clear separation while
  remaining straightforward to operate and evolve.

### Trade-offs

- Two AWS accounts require deliberate IAM and deployment-role design.
- Production deployment must cross an AWS account boundary.
- Backup and recovery architecture must be designed before production
  launch.
- DEV must remain sufficiently production-representative for
  meaningful testing.

## Revisit Conditions

Reconsider the environment model only if business scale, development
team size, external testing requirements, compliance obligations,
release frequency, or integration complexity materially change.
