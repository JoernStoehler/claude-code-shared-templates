#!/bin/bash
# ==============================================================================
# 05-install-claude-code-common-tools.sh
# ==============================================================================
# PURPOSE: Install common development tools that enhance Claude Code's capabilities
# 
# DESCRIPTION:
#   Installs a curated set of command-line tools that Claude Code frequently
#   uses for file searching, text processing, and development workflows.
#
# TOOLS INSTALLED:
#   - ripgrep (rg): Fast text search tool with regex support
#   - fd-find (fd): Fast and user-friendly alternative to find
#   - jq: JSON processor and formatter
#
# NOTES:
#   - All tools are installed via apt-get for consistent versions
#   - These tools significantly improve Claude Code's ability to explore codebases
# ==============================================================================

set -e

echo "Installing common tools for Claude Code..."

# Update package list
sudo apt-get update -qq

# Install tools via apt-get
# Using -qq for quiet output and -y for non-interactive
sudo apt-get install -qq -y \
    ripgrep \
    fd-find \
    jq

# Create symlinks for tools with different binary names
# fd-find installs as 'fdfind' on Debian/Ubuntu
if command -v fdfind &> /dev/null && ! command -v fd &> /dev/null; then
    sudo ln -s $(which fdfind) /usr/local/bin/fd
    echo "✓ Created symlink: fd -> fdfind"
fi


# Verify installations
echo ""
echo "Installed tools:"
command -v rg &> /dev/null && echo "✓ ripgrep (rg) $(rg --version | head -1)"
command -v fd &> /dev/null && echo "✓ fd $(fd --version)"
command -v jq &> /dev/null && echo "✓ jq $(jq --version)"

echo ""
echo "✓ Common tools installation complete"