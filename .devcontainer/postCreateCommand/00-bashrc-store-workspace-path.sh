#!/bin/bash
# ==============================================================================
# 00-bashrc-store-workspace-path.sh
# ==============================================================================
# PURPOSE: Define and persist the WORKSPACE_PATH environment variable
#
# DESCRIPTION:
#   Creates a reliable WORKSPACE_PATH environment variable that other scripts
#   can use to reference the workspace directory. This solves the problem where
#   containerWorkspaceFolder and CODESPACE_VSCODE_FOLDER are not reliably
#   available during postCreateCommand execution.
#
# SETS ENVIRONMENT VARIABLE:
#   - WORKSPACE_PATH: Absolute path to the workspace directory
#
# NOTES:
#   - This script must run first (00-) as other scripts depend on WORKSPACE_PATH
#   - The variable is persisted in ~/.bashrc for new shell sessions
#   - Uses pwd to get the current directory, which is the workspace during setup
# ==============================================================================

set -e

echo "Setting up WORKSPACE_PATH environment variable..."

# Get the absolute path of the workspace directory
# During postCreateCommand, we're already in the workspace directory
export WORKSPACE_PATH=$(pwd)

echo "✓ WORKSPACE_PATH set to: $WORKSPACE_PATH"

# Add the WORKSPACE_PATH to ~/.bashrc for persistence
# Check if it already exists to avoid duplicates
if ! grep -q "export WORKSPACE_PATH=" ~/.bashrc; then
    cat >> ~/.bashrc << EOF

# Workspace directory path (set by devcontainer setup)
export WORKSPACE_PATH="${WORKSPACE_PATH}"
EOF
    echo "✓ WORKSPACE_PATH added to ~/.bashrc"
else
    # Update existing WORKSPACE_PATH in case it changed
    sed -i "s|export WORKSPACE_PATH=.*|export WORKSPACE_PATH=\"${WORKSPACE_PATH}\"|" ~/.bashrc
    echo "✓ WORKSPACE_PATH updated in ~/.bashrc"
fi

echo "✓ WORKSPACE_PATH environment variable configured successfully"