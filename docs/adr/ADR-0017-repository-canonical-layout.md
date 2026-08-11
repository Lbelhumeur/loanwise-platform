# ADR-0017: Canonical Repository Layout

**Status:** Accepted

The LoanWise repository root is the canonical application root.

Terraform is organized exclusively beneath `infrastructure/`:

- `infrastructure/bootstrap/`
- `infrastructure/environments/`
- `infrastructure/modules/`

Work-item ZIP archives are backup artifacts and are not committed to the
application repository.

Git history is preserved; cleanup is performed as a normal forward commit.
