#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
REPO_URL="https://github.com/dcat23/aliascli.git"
INSTALL_DIR="$HOME/.aliascli"

# Detect the shell and set SHELL_CONFIG_FILE
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG_FILE="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_CONFIG_FILE="$HOME/.bashrc"
else
    echo "Unsupported shell: $SHELL"
    exit 1
fi

# SHELL_CONFIG_FILE="$HOME/.bashrc" # Change to ~/.zshrc if using Zsh

# Step 1: Clone the repository
echo "Cloning Alias CLI repository..."
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory $INSTALL_DIR already exists. Skipping clone."
else
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Step 2: Make alias_cli executable
echo "Making alias_cli executable..."
chmod +x "$INSTALL_DIR/alias_cli"

# Step 3: Add alias_cli to shell configuration for persistent access
echo "Adding alias_cli to shell configuration file ($SHELL_CONFIG_FILE)..."
if ! grep -q "source $INSTALL_DIR/alias_cli" "$SHELL_CONFIG_FILE"; then
    echo "export ALIAS_CLI_DIR=\"$INSTALL_DIR\"" >> "$SHELL_CONFIG_FILE" 
    echo "source \"$INSTALL_DIR/alias_cli\"" >> "$SHELL_CONFIG_FILE"
    echo "Alias CLI added successfully."
else
    echo "Alias CLI already exists in $SHELL_CONFIG_FILE."
fi

# Step 4: Reload shell configuration file
echo "Reloading shell configuration..."
source "$SHELL_CONFIG_FILE"

echo "Installation complete! You can now use 'al' command globally."

