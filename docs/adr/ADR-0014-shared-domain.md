# ADR-0014: Shared Domain Package

**Status:** Accepted

Core business types are maintained in `@loanwise/domain`. The domain package is platform-neutral and must not contain AWS SDK, React, browser, or infrastructure implementation details.
