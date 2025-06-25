#!/bin/bash
# ==============================================================================
# 11-setup-cleaner-bash-prompt.sh
# ==============================================================================
# PURPOSE: Configure a cleaner, more readable bash prompt for VS Code terminals
# 
# DESCRIPTION:
#   Replaces the complex default devcontainer prompt with a simpler format that
#   shows essential information without clutter. The new prompt displays the full
#   username and current path with clear visual separation.
#
# PROMPT FORMAT:
#   Before: (venv) hostname ➜ /full/path (branch) $
#   After:  user: /full/path $ 
#
# FEATURES:
#   - Full username (green) for clarity
#   - Full working directory path (blue) for navigation
#   - Clean spacing between elements
#   - No redundant information (venv name, git branch, hostname)
#
# NOTE: This runs after the default __bash_prompt function and overrides it
#       using PROMPT_COMMAND to ensure the cleaner prompt takes precedence.
# ==============================================================================

set -e

echo "Setting up cleaner bash prompt..."

# Add custom prompt configuration to .bashrc
cat >> ~/.bashrc << 'EOF'

# Custom cleaner prompt - override the complex one
# This needs to run after the __bash_prompt function
cleaner_prompt() {
    # Simple format: user: path $ 
    # Green user, blue path, with spacing for clarity
    PS1="\[\033[32m\]${USER}\[\033[0m\]: \[\033[34m\]${PWD}\[\033[0m\] \$ "
}

# Set the cleaner prompt
PROMPT_COMMAND="cleaner_prompt"
EOF

echo "✓ Cleaner bash prompt configured"