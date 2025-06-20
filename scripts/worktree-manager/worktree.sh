#!/bin/bash
# Worktree management helper for parallel Claude Code development

set -e

WORKSPACE_ROOT="/workspaces"
MAIN_REPO="${WORKSPACE_ROOT}/seminar-ki-in-der-mathematik"

case "$1" in
  create)
    if [ -z "$2" ]; then
      echo "Usage: $0 create <branch-name> [base-branch]"
      exit 1
    fi
    BRANCH_NAME="$2"
    BASE_BRANCH="${3:-main}"
    WORKTREE_PATH="${WORKSPACE_ROOT}/${BRANCH_NAME}"
    
    cd "$MAIN_REPO"
    git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH" "$BASE_BRANCH"
    echo "Created worktree at: $WORKTREE_PATH"
    echo "To open in VS Code: code $WORKTREE_PATH"
    ;;
    
  list)
    cd "$MAIN_REPO"
    git worktree list
    ;;
    
  open)
    if [ -z "$2" ]; then
      echo "Usage: $0 open <branch-name>"
      exit 1
    fi
    WORKTREE_PATH="${WORKSPACE_ROOT}/$2"
    if [ -d "$WORKTREE_PATH" ]; then
      code "$WORKTREE_PATH"
    else
      echo "Worktree not found at: $WORKTREE_PATH"
      exit 1
    fi
    ;;
    
  remove)
    if [ -z "$2" ]; then
      echo "Usage: $0 remove <branch-name>"
      exit 1
    fi
    cd "$MAIN_REPO"
    git worktree remove "${WORKSPACE_ROOT}/$2"
    echo "Removed worktree: ${WORKSPACE_ROOT}/$2"
    ;;
    
  *)
    echo "Git Worktree Manager for Claude Code Development"
    echo ""
    echo "Usage:"
    echo "  $0 create <branch-name> [base-branch]  - Create new worktree"
    echo "  $0 list                                - List all worktrees"
    echo "  $0 open <branch-name>                  - Open worktree in VS Code"
    echo "  $0 remove <branch-name>                - Remove worktree"
    echo ""
    echo "Example workflow:"
    echo "  $0 create feat-auth                    # Creates /workspaces/feat-auth"
    echo "  $0 open feat-auth                      # Opens in new VS Code window"
    echo "  $0 list                                # Shows all active worktrees"
    echo "  $0 remove feat-auth                    # Cleans up when done"
    ;;
esac