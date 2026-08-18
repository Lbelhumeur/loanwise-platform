# Monorepo & Workspace Standard

## Workspaces

- `frontend/*` — browser applications
- `backend/*` — Lambda/API services
- `packages/*` — reusable application libraries

## Dependency rules

1. Frontends may consume shared packages.
2. Backends may consume shared packages.
3. Shared packages must not depend on application-specific code.
4. Domain models must not depend on AWS SDKs.
5. Infrastructure must not import application packages.
6. Tenant identity belongs at the domain/application boundary.

Internal packages use the `@loanwise/` scope.

The initial tenant is `loanwise`; tenant IDs are represented as domain values so additional tenants can be introduced later without redesigning application interfaces.
