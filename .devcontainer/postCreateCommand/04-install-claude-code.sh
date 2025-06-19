#!/bin/bash
# ==============================================================================
# 04-install-claude-code.sh
# ==============================================================================
# PURPOSE: Install Claude Code CLI globally via npm
# 
# DESCRIPTION:
#   Installs the latest version of Claude Code CLI using npm with global
#   installation. The global installation allows the 'claude' command to be
#   available system-wide without sudo for updates.
#
# INSTALLATION METHOD:
#   Uses npm with --global flag and specific directory configuration to avoid
#   requiring sudo for future updates by the user.
#
# POST-INSTALL:
#   - 'claude' command available globally
#   - User can update via: npm update -g @anthropic-ai/claude-code
# ==============================================================================

set -e

echo "Installing Claude Code CLI..."

# Ensure npm global directory is set up for user (not root)
NPM_GLOBAL_DIR="$HOME/.npm-global"
mkdir -p "$NPM_GLOBAL_DIR"

# Configure npm to use user directory for global installs
npm config set prefix "$NPM_GLOBAL_DIR"

# Add npm global bin to PATH if not already there
if ! grep -q "$NPM_GLOBAL_DIR/bin" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# npm global bin directory" >> ~/.bashrc
    echo "export PATH=\"\$PATH:$NPM_GLOBAL_DIR/bin\"" >> ~/.bashrc
fi

# Export for current session
export PATH="$PATH:$NPM_GLOBAL_DIR/bin"

# Install Claude Code CLI
npm install -g @anthropic-ai/claude-code

# Verify installation
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "version unknown")
    echo "✓ Claude Code CLI installed successfully ($CLAUDE_VERSION)"
else
    echo "⚠ Claude Code CLI installation completed but 'claude' command not found in PATH"
    echo "  You may need to restart your shell or run: source ~/.bashrc"
fi