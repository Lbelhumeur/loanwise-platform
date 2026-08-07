export type TenantId = string & { readonly __brand: 'TenantId' };

export interface TenantFeatures {
  certificates: boolean;
  quizzes: boolean;
  notes: boolean;
  reporting: boolean;
  aiTutor: boolean;
  discussionBoards: boolean;
}

export interface TenantBranding {
  displayName: string;
  organizationName: string;
  logoUrl?: string;
}

export interface Tenant {
  tenantId: TenantId;
  branding: TenantBranding;
  features: TenantFeatures;
  active: boolean;
}