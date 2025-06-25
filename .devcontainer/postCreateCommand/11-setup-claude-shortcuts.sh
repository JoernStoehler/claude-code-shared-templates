#!/bin/bash
#
# 11-setup-claude-shortcuts.sh - Set up claude-worktree and claude-clone commands
#
# This script sets up the repository management commands for easy access.
#

set -e

echo "Setting up claude-worktree and claude-clone commands..."

# Get the workspace path (should be set by containerEnv)
WORKSPACE_PATH="${WORKSPACE_PATH:-/workspaces/$(basename $(pwd))}"

# Add to PATH via bashrc
cat >> ~/.bashrc << 'EOF'

# Add claude-worktree and claude-clone to PATH
export PATH="${WORKSPACE_PATH}/scripts/worktree-manager:$PATH"

# Bash completion for claude-worktree command
_claude_worktree_complete() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Main commands
    if [ $COMP_CWORD -eq 1 ]; then
        opts="create remove status"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
    
    # Command-specific completions
    case "${COMP_WORDS[1]}" in
        create)
            if [ $COMP_CWORD -eq 2 ]; then
                # Suggest common branch prefixes
                opts="feat/ fix/ docs/ refactor/ test/ chore/"
                COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            fi
            ;;
        remove)
            if [ $COMP_CWORD -eq 2 ]; then
                # Complete with existing worktree branches
                if command -v git &> /dev/null; then
                    # Get branches from worktrees
                    local branches=$(git worktree list --porcelain 2>/dev/null | grep "^branch" | cut -d' ' -f2 | sed 's|refs/heads/||')
                    # Also add /workspaces/ directories
                    local dirs=$(ls -d /workspaces/*/ 2>/dev/null | xargs -n1 basename)
                    opts="$branches $dirs"
                    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
                fi
            fi
            ;;
    esac
}

complete -F _claude_worktree_complete claude-worktree

# Bash completion for claude-clone command
_claude_clone_complete() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Main commands
    if [ $COMP_CWORD -eq 1 ]; then
        opts="clone remove status"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
    
    # Command-specific completions
    case "${COMP_WORDS[1]}" in
        remove)
            if [ $COMP_CWORD -eq 2 ]; then
                # Complete with repository directories in /workspaces
                local dirs=$(ls -d /workspaces/*/ 2>/dev/null | xargs -n1 basename | grep -v "^feat-" | grep -v "^fix-")
                COMPREPLY=( $(compgen -W "${dirs}" -- ${cur}) )
            fi
            ;;
    esac
}

complete -F _claude_clone_complete claude-clone

EOF

echo "✓ Repository management commands configured successfully!"
echo ""
echo "Available commands:"
echo ""
echo "Git worktree management:"
echo "  claude-worktree create <branch>  - Create a new worktree"
echo "  claude-worktree remove <branch>  - Remove a worktree"
echo "  claude-worktree status          - Show workspace status"
echo ""
echo "Repository cloning:"
echo "  claude-clone clone <repo> [name] - Clone a repository"
echo "  claude-clone remove <repo>       - Remove a cloned repository"
echo "  claude-clone status             - Show all repositories"
echo ""
echo "Run 'source ~/.bashrc' to activate in current shell"