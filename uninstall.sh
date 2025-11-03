#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SCRIPT_NAME="git-commit-shortcuts.zsh"
TARGET_FILE=~/".${SCRIPT_NAME}"
ZSHRC=~/.zshrc
SOURCE_LINE="source ~/.${SCRIPT_NAME}"

# Remove the script file
if [ -f "$TARGET_FILE" ]; then
    rm -f "$TARGET_FILE"
    echo -e "${GREEN}✓ Removed ${TARGET_FILE}${NC}"
else
    echo -e "${YELLOW}ℹ️  ${TARGET_FILE} not found, skipping...${NC}"
fi

# Remove the source line from .zshrc
if [ -f "$ZSHRC" ] && grep -qF "$SOURCE_LINE" "$ZSHRC"; then
    # Create a backup of the current .zshrc
    cp "$ZSHRC" "${ZSHRC}.bak"
    # Remove the source line and any empty lines around it
    sed -i '' "/^# Git Commit Shortcuts$/{N;N;d;};" "$ZSHRC" 2>/dev/null || \
    sed -i "/^# Git Commit Shortcuts$/{N;N;d;}" "$ZSHRC"
    echo -e "${GREEN}✓ Removed git-commit-shortcuts from ${ZSHRC}${NC}"
    echo -e "${YELLOW}ℹ️  A backup of your original .zshrc has been saved as ${ZSHRC}.bak${NC}"
else
    echo -e "${YELLOW}ℹ️  No git-commit-shortcuts reference found in ${ZSHRC}${NC}"
fi

# Remove the cloned directory if we're running from a cloned repo
if [ -d ~/.git-commit-shortcuts ]; then
    rm -rf ~/.git-commit-shortcuts
    echo -e "${GREEN}✓ Removed ~/.git-commit-shortcuts directory${NC}"
fi

echo -e "\n${GREEN}✅ Uninstallation complete!${NC}"
echo -e "To apply changes, run: ${YELLOW}source ~/.zshrc${NC} or restart your terminal."

exit 0
