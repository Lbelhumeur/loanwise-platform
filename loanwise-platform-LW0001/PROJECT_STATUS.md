# Project Status

**Product:** LoanWise Method  
**Business:** LoanWise Consulting  
**Internal codename:** Project Phoenix  
**Phase:** Foundation  
**Work item:** LW-0001 Repository Bootstrap  
**Status:** Ready for commit

## Architecture
- Tenant-aware from day one; LoanWise is the initial tenant.
- Cognito for identity.
- Terraform is the infrastructure source of truth.
- React + TypeScript + Vite.
- Lambda + API Gateway.
- DynamoDB for application data.
- S3 + CloudFront for web/content delivery.
