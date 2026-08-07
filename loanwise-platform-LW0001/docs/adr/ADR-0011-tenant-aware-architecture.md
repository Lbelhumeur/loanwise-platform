# ADR-0011: Tenant-Aware Architecture

**Status:** Accepted

The platform is tenant-aware from its foundation but initially operates with a single tenant: `loanwise`.

Tenant context must be represented in the domain/data model and enforced by backend services. Self-service tenant provisioning is outside the initial MVP.
