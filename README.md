# Git Commit Shortcuts

A convenient Zsh script that provides shortcuts for creating standardized git commit messages with emoji prefixes and consistent formatting.

## Installation

### One-line installation

Run this single command to install and set up everything automatically:

```bash
bash -c "git clone https://github.com/ashsajal1/git-commit-shortcuts.git ~/.git-commit-shortcuts && cp ~/.git-commit-shortcuts/git-commit-shortcuts.zsh ~/.git-commit-shortcuts.zsh && echo 'source ~/.git-commit-shortcuts.zsh' >> ~/.zshrc && source ~/.zshrc && echo -e '\\n\\033[0;32m✅ Git Commit Shortcuts installed successfully! Run ghelp to see available commands.\\033[0m'"
```

### Manual Installation

1. Copy the script to your home directory:
   ```bash
   cp git-commit-shortcuts.zsh ~/.git-commit-shortcuts.zsh
   ```

2. Add this line to your `~/.zshrc`:
   ```bash
   source ~/.git-commit-shortcuts.zsh
   ```

3. Reload your shell configuration:
   ```bash
   source ~/.zshrc
   ```

## Available Commands

| Command  | Emoji | Description                |
|----------|-------|----------------------------|
| `gfeat`  | ✨    | New feature                |
| `gfix`   | 🐛    | Bug fix                    |
| `gdocs`  | 📝    | Documentation changes       |
| `gstyle` | 💄    | Code style/formatting       |
| `grefactor` | ♻️ | Code refactoring           |
| `gperf`  | ⚡    | Performance improvements    |
| `gtest`  | ✅    | Adding or updating tests    |
| `gchore` | 🔧    | Maintenance tasks           |
| `gbuild` | 🏗️   | Build system changes        |
| `gci`    | 🔁    | CI/CD configuration changes |
| `grevert`| ⏪   | Revert previous commits     |
| `greset` | 🔄   | Soft reset to previous commit (HEAD~1 by default) |

## Usage

### Reset Command

Soft reset to the previous commit (HEAD~1) or a specified commit:

```bash
# Reset to previous commit
greset

# Reset to a specific commit
greset abc123

# Reset 2 commits back
greset HEAD~2
```

### Basic Usage (with subject)
```bash
gfeat add login button
# Commits with message: "✨ feat: add login button"

# With multi-word subject (use quotes)
gfix "resolve issue with user authentication"
```

### Interactive Mode (prompted subject)
```bash
gdocs
# Will prompt: "Commit subject for 📝 docs: "
# Type your subject and press Enter
```

### With Multi-line Body
You can add a detailed commit message body using pipes or file redirection:

```bash
# Using pipe
echo $'Detailed description\n\n- Added new API endpoint\n- Updated documentation' | gfeat implement user authentication

# Using file redirection
grefactor improve code structure < changes.txt
```

### View Available Commands
```bash
ghelp
```

## Notes
- The script automatically stages all changes (`git add -A`) before committing.
- To modify this behavior, edit the script and remove or change the `git add` line.
- All commit messages follow the format: `[EMOJI] type: subject`

## Customization
You can customize the commit types and their corresponding emojis by modifying the `types_map` array in the script.