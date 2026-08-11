import type { TenantId } from './tenant.js';

export type UserId = string & { readonly __brand: 'UserId' };

export type UserRole =
  | 'student'
  | 'instructor'
  | 'administrator'
  | 'platform-admin';

export interface UserIdentity {
  userId: UserId;
  tenantId: TenantId;
  roles: UserRole[];
  email?: string;
}
