#!/bin/bash
# ==============================================================================
# 07-fix-workspaces-permissions.sh
# ==============================================================================
# PURPOSE: Ensure /workspaces directory has proper permissions for git worktrees
# 
# DESCRIPTION:
#   Changes ownership of /workspaces directory from root to the current user.
#   This enables creation of git worktrees at /workspaces/{branch-name} without
#   requiring sudo, following the project's documented conventions.
#
# PROBLEM ADDRESSED:
#   - Default devcontainer setup creates /workspaces owned by root
#   - Git worktree creation fails with permission denied
#   - Claude Code agents shouldn't need sudo for normal operations
#
# IMPLEMENTATION:
#   - Changes /workspaces ownership to current user (codespace)
#   - Preserves existing permissions for subdirectories
#   - Safe to run multiple times (idempotent)
# ==============================================================================

set -e

echo "Fixing /workspaces directory permissions for git worktrees..."

# Check if we're in a devcontainer environment
if [ ! -d "/workspaces" ]; then
    echo "ℹ /workspaces directory not found - skipping permission fix"
    echo "  This is expected in non-devcontainer environments"
    exit 0
fi

# Get the current user
CURRENT_USER=$(whoami)
CURRENT_GROUP=$(id -gn)

# Check current ownership
CURRENT_OWNER=$(stat -c '%U' /workspaces)
if [ "$CURRENT_OWNER" = "$CURRENT_USER" ]; then
    echo "ℹ /workspaces is already owned by $CURRENT_USER"
    echo "  Skipping permission change"
    exit 0
fi

# Show current state
echo "Current /workspaces ownership: $CURRENT_OWNER"
echo "Changing to: $CURRENT_USER:$CURRENT_GROUP"

# Change ownership
if sudo chown "$CURRENT_USER:$CURRENT_GROUP" /workspaces; then
    echo "✓ Successfully changed /workspaces ownership"
    
    # Verify the change
    NEW_OWNER=$(stat -c '%U' /workspaces)
    if [ "$NEW_OWNER" = "$CURRENT_USER" ]; then
        echo "✓ Verified: /workspaces is now owned by $CURRENT_USER"
        echo ""
        echo "Git worktrees can now be created at:"
        echo "  • /workspaces/feat-{feature-name}"
        echo "  • /workspaces/fix-{bug-name}"
        echo "  • /workspaces/docs-{doc-name}"
    else
        echo "❌ Verification failed: ownership didn't change as expected"
        exit 1
    fi
else
    echo "❌ Failed to change /workspaces ownership"
    echo "  Git worktrees will need to be created in alternate locations"
    exit 1
fi