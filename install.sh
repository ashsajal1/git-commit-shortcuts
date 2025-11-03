#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SCRIPT_NAME="git-commit-shortcuts.zsh"
TARGET_DIR=~/
TARGET_FILE="${TARGET_DIR}.${SCRIPT_NAME}"
ZSHRC=~/.zshrc
SOURCE_LINE="source ~/.${SCRIPT_NAME}"

# Check if script exists in the current directory
if [ ! -f "$SCRIPT_NAME" ]; then
    echo "Error: $SCRIPT_NAME not found in the current directory"
    exit 1
fi

# Copy the script to home directory
echo -e "${GREEN}Copying $SCRIPT_NAME to $TARGET_FILE${NC}"
cp "$SCRIPT_NAME" "$TARGET_FILE"
chmod +x "$TARGET_FILE"

# Check if already installed in .zshrc
if grep -qF "$SOURCE_LINE" "$ZSHRC"; then
    echo -e "${YELLOW}Note: $SCRIPT_NAME is already sourced in $ZSHRC${NC}"
else
    echo -e "${GREEN}Adding source to $ZSHRC${NC}"
    echo -e "\n# Git Commit Shortcuts\n$SOURCE_LINE" >> "$ZSHRC"
fi

# Test if the script is working
echo -e "\n${GREEN}Installation complete!${NC}"
echo "To start using the shortcuts, run:"
echo -e "${YELLOW}source ~/.zshrc${NC}"
echo -e "\nTo verify installation, run:"
echo -e "${YELLOW}ghelp${NC} (should show available commands)"

exit 0
