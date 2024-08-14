import { select } from '@inquirer/prompts';
import figlet from 'figlet';


// Display welcome message
const displayWelcomeMessage = async () => {
  const chalk = await import('chalk');
  console.log(
    chalk.default.red.bgYellowBright(
      figlet.textSync('Fired Up AI', {
        font: 'Standard',
        horizontalLayout: 'default',
        verticalLayout: 'default'
      })
    )
  );
};

// Main function
const main = async () => {
  await displayWelcomeMessage();

  const choice = await select({
    message: 'What would you like to do?',
    choices: [
      { name: 'Install Dependencies', 
        value: 'setup',
        description: 'Install necessary dependencies for the project',
        short: "setup" 
      },
      { name: 'Initialize Monorepo', 
        value: 'init',
        description: 'Initialize a new monorepo',
        short: "init"
      },
      { 
        name: 'Create Package', 
        value: 'create-package',
        description: 'Create a new package in the monorepo',
        short: "create-package" 
      },
      {
        name: 'Exit',
        value: 'exit',
        description: 'Exit the CLI',
        short: "exit"
      }
    ]
  });

  switch (choice) {
    case 'setup':
      await import('./commands/setup');
      break;
    case 'init':
      await import('./commands/init');
      break;
    case 'create-package':
      await import('./commands/create-package');
      break;
    case 'exit':
      console.log('Exiting CLI... GOODBYE!');
      process.exit(0);
      
    default:
      const chalk = await import('chalk');
      console.log(chalk.default.red('Invalid choice.'));
  }
};

main();
