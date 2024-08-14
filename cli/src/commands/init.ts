
import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import { input } from '@inquirer/prompts';








const init = async () => {
  const name = await input({
    message: 'Enter the name of the monorepo',
    required: true,
    validate(value) {
      if (value.length < 3) {
        return 'Name must be at least 3 characters long';
      }
      return true;
    }
  });

  const folder = process.cwd();
  const repoPath = path.join(folder, name);

  if (fs.existsSync(repoPath)) {
    console.log('Folder already exists');
    return;
  }

  const chalk = await import('chalk');
  console.log(chalk.default.magenta("Creating Mono-Repo at: "), repoPath);
  fs.mkdirSync(repoPath);
  execSync('yarn init -y', { cwd: repoPath, stdio: 'inherit' });

  console.log(chalk.default.blue('Creating directories for workspaces: ') + chalk.default.green('packages, apps'));
  const packagesPath = path.join(repoPath, 'packages');
  fs.mkdirSync(packagesPath);
  const appsPath = path.join(repoPath, 'apps');
  fs.mkdirSync(appsPath);

  // Update package.json to include workspaces
  const packageJsonPath = path.join(repoPath, 'package.json');
  const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf-8'));
  packageJson.workspaces = [
    "packages/*",
    "apps/*"
  ];
  fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));

  console.log(chalk.default.green('Mono-Repo initialized successfully'));
  process.exit(0);
};

export default init;


