import type { TenantFeatures } from '@loanwise/domain';

export interface AppConfig {
  environment: 'dev' | 'stage' | 'prod';
  apiBaseUrl: string;
  tenantId: string;
  features: TenantFeatures;
}

export const defaultLoanWiseFeatures: TenantFeatures = {
  certificates: true,
  quizzes: true,
  notes: true,
  reporting: true,
  aiTutor: false,
  discussionBoards: false,
};
