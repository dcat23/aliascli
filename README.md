# Alias CLI

## **Usage**

To use Alias CLI, you need to have the `alias_cli.sh` script and the `alias_commands` file in the same directory.

The `alias_commands` file contains the list of aliases that you want to manage with AliasCLI. Each alias should be defined as follows:

```bash
alias alias_name='command'
```

To manage aliases with Alias CLI, simply run the `al` command followed by the appropriate arguments.

```bash
al [-h] [<alias> <command>] [-v <alias>] [-d <alias>]
```

Here is a brief description of the available options:

* `-h`: Show the help page.
    
* `<alias>`: If provided with a `<command>`, create or update an alias. If no `<command>` is provided, list all aliases or list aliases that contain `<alias>`.
    
* `-v <alias>`: View the command for a specific alias.
    
* `-d <alias>`: Delete an alias.
    

For example, to create a new alias called "cm" that runs the "git commit -md" command, you would run the following command:

```bash
al cm "git commit -m"
```
> NOTE: Be sure to include quotations around the command 

To view the command associated with the "cm" alias, you would run:

```bash
al -v cm
# cm -> alias cm="git commit -m"
```

To delete alias "cm", you would run:

```bash
al -d cm
```

*Example:*
```bash
al cl "git clone"
# immediately available
cl https://github.com/dcat23/AliasCLI.git
```

For more information about the available commands, run `al -h`. This will display a help

## **Adding to Your Shell Configuration**

To make the `al` function available in every new terminal window, you can add the following command to your shell configuration file:

```bash
source /path/to/AliasCLI/alias_cli.sh
```

Replace `/path/to/AliasCLI/` with the actual path to the AliasCLI folder on your system.

Once you've added this line to your shell configuration file, the `al` function will be loaded automatically every time you open a new terminal window.

To make the `al` function available in each new terminal from any directory, you can add `source "$HOME/AliasCLI/alias_cli.sh"` command to your shell configuration file (~/.bashrc for Bash or ~/.zshrc for Zsh):

## Temporary Shell Variables
- `echo $ALIAS_COMMANDS_FILE`: location of aliases
- `echo $EXISTING_COMMAND`: most recently updated alias
- `echo $DELETED_COMMAND`: most recently deleted alias
- `./alias_commands.bak`: backup before recent changes

## **License**

Alias CLI is licensed under the [**MIT License**](https://opensource.org/license/mit).
