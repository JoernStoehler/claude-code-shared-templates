#!/bin/bash
# ==============================================================================
# 08-add-template-remote.sh
# ==============================================================================
# PURPOSE: Add Claude Code shared templates repository as a git remote
# 
# DESCRIPTION:
#   Configures the template repository as a git remote named 'template' to
#   enable cherry-picking useful files and improvements from the shared
#   template repository. This supports bidirectional synchronization of
#   enhancements between projects.
#
# BEHAVIOR:
#   - Checks if already in a git repository
#   - Adds remote if it doesn't exist
#   - Updates remote URL if it points to wrong location
#   - Fetches latest references from template
#
# TEMPLATE REPOSITORY:
#   - Remote name: template
#   - URL: https://github.com/JoernStoehler/claude-code-shared-templates.git
# ==============================================================================

echo "[devcontainer] Adding template repository as git remote..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "[devcontainer] ERROR: Not in a git repository. Skipping template remote setup."
    exit 0
fi

# Check if 'template' remote already exists
if git remote get-url template > /dev/null 2>&1; then
    echo "[devcontainer] Template remote already exists. Checking URL..."
    current_url=$(git remote get-url template)
    expected_url="https://github.com/JoernStoehler/claude-code-shared-templates.git"
    
    if [ "$current_url" != "$expected_url" ]; then
        echo "[devcontainer] WARNING: Template remote exists but points to: $current_url"
        echo "[devcontainer] Expected: $expected_url"
        echo "[devcontainer] Updating template remote URL..."
        git remote set-url template "$expected_url"
        echo "[devcontainer] Template remote URL updated successfully"
    else
        echo "[devcontainer] Template remote already configured correctly"
    fi
else
    # Add the template remote
    echo "[devcontainer] Adding template remote..."
    git remote add template https://github.com/JoernStoehler/claude-code-shared-templates.git
    echo "[devcontainer] Template remote added successfully"
fi

# Fetch from the template remote to ensure we have the latest references
echo "[devcontainer] Fetching from template remote..."
git fetch template --quiet || {
    echo "[devcontainer] WARNING: Failed to fetch from template remote. This might be due to network issues."
    echo "[devcontainer] You can manually fetch later with: git fetch template"
}

echo "[devcontainer] Template remote setup complete"
echo "[devcontainer] You can now:"
echo "[devcontainer]   - View template branches: git branch -r | grep template/"
echo "[devcontainer]   - Cherry-pick commits: git cherry-pick <commit-hash>"
echo "[devcontainer]   - Merge template changes: git merge template/main"
echo "[devcontainer]   - Compare files: git diff HEAD template/main -- <file>"