import { readFile } from 'node:fs/promises';

const packageJson = JSON.parse(await readFile('package.json', 'utf8'));
const required = ['frontend/*', 'backend/*', 'packages/*'];

for (const workspace of required) {
  if (!packageJson.workspaces.includes(workspace)) {
    throw new Error(`Missing workspace: ${workspace}`);
  }
}

console.log('LoanWise workspace configuration OK');
