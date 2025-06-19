#!/bin/bash
# ==============================================================================
# 03-bashrc-setups-claude-code-config-dir-in-workspace.sh
# ==============================================================================
# PURPOSE: Configure persistent Claude Code configuration directory
# 
# DESCRIPTION:
#   Moves the Claude Code configuration directory into the workspace to ensure
#   it persists across container rebuilds. This eliminates the need to
#   re-authenticate with OAuth on every rebuild.
#
# CHANGES:
#   Default: ~/.claude-config (lost on container rebuild)
#   New: {workspace}/.claude-config (persisted across rebuilds)
#
# ACTIONS:
#   1. Sets CLAUDE_CODE_CONFIG_DIR environment variable
#   2. Creates the configuration directory
#   3. Adds directory to .gitignore if not already present
#   4. Configures ~/.bashrc for persistence
# ==============================================================================

set -e

echo "Setting up persistent Claude Code configuration directory..."

# Use the WORKSPACE_PATH set by 00-bashrc-store-workspace-path.sh
# Export for current session
export CLAUDE_CODE_CONFIG_DIR="${WORKSPACE_PATH}/.claude-config"

# Create the directory
mkdir -p "${CLAUDE_CODE_CONFIG_DIR}"
echo "✓ Created configuration directory at ${CLAUDE_CODE_CONFIG_DIR}"

# Add to .gitignore if not already present
GITIGNORE_PATH="${WORKSPACE_PATH}/.gitignore"
if [ -f "$GITIGNORE_PATH" ]; then
    if ! grep -q "^\.claude-config$" "$GITIGNORE_PATH" 2>/dev/null; then
        echo "" >> "$GITIGNORE_PATH"
        echo "# Claude Code configuration (contains OAuth tokens)" >> "$GITIGNORE_PATH"
        echo ".claude-config" >> "$GITIGNORE_PATH"
        echo "✓ Added .claude-config to .gitignore"
    else
        echo "✓ .claude-config already in .gitignore"
    fi
else
    echo "# Claude Code configuration (contains OAuth tokens)" > "$GITIGNORE_PATH"
    echo ".claude-config" >> "$GITIGNORE_PATH"
    echo "✓ Created .gitignore with .claude-config entry"
fi

# Add to ~/.bashrc for persistence
cat >> ~/.bashrc << EOF

# Claude Code configuration directory (persisted across container rebuilds)
export CLAUDE_CODE_CONFIG_DIR="\${WORKSPACE_PATH}/.claude-config"
EOF

echo "✓ Claude Code configuration directory setup complete"