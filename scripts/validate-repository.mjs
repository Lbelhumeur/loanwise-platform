import { access, readFile } from 'node:fs/promises';

const required = [
  'package.json',
  'tsconfig.base.json',
  'frontend',
  'backend',
  'packages',
  'infrastructure',
  'docs',
];

for (const path of required) {
  await access(path);
}

const pkg = JSON.parse(await readFile('package.json', 'utf8'));

for (const workspace of ['frontend/*', 'backend/*', 'packages/*']) {
  if (!pkg.workspaces?.includes(workspace)) {
    throw new Error(`Missing workspace: ${workspace}`);
  }
}

console.log('LoanWise repository structure OK');
