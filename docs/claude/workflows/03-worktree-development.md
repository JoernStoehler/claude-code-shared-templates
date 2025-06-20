# Git Worktree Development Workflow

## Overview

This project uses git worktrees to enable parallel development across multiple features. Each Claude Code instance works in its own isolated worktree, allowing multiple agents to work simultaneously without conflicts.

## Quick Start

### Creating a New Feature Worktree

```bash
# Create worktree for a new feature
git worktree add /workspaces/feat-authentication -b feat/authentication

# Add to VS Code workspace
code --add /workspaces/feat-authentication

# Start Claude Code in the worktree
cd /workspaces/feat-authentication
```

### Worktree Naming Conventions

Follow conventional commit style prefixes:
- `/workspaces/feat-{name}` - New features
- `/workspaces/fix-{name}` - Bug fixes
- `/workspaces/docs-{name}` - Documentation updates
- `/workspaces/refactor-{name}` - Code refactoring
- `/workspaces/test-{name}` - Test additions

## How It Works

### Directory Structure

```
/workspaces/
├── seminar-ki-in-der-mathematik/     # Main repository
├── feat-authentication/              # Feature worktree
├── fix-parser-bug/                   # Bugfix worktree
└── docs-api-update/                  # Documentation worktree
```

### Isolation Benefits

Each worktree provides:
- **Independent Git State**: Separate branch, staging area, and commits
- **Isolated Python Environment**: Own `.venv` directory
- **Separate Working Directory**: No file conflicts between agents
- **Independent Terminal Sessions**: Each Claude Code maintains its own cwd

### VS Code Integration

The multi-root workspace shows all worktrees in the explorer:
```
UNTITLED (WORKSPACE)
├── seminar-ki-in-der-mathematik
│   └── [main branch files]
├── feat-authentication
│   └── [feature branch files]
└── fix-parser-bug
    └── [bugfix branch files]
```

## Step-by-Step Workflow

### 1. Create a Worktree

```bash
# From main repository
git worktree add /workspaces/feat-oauth -b feat/oauth

# Or base on existing branch
git worktree add /workspaces/fix-memory-leak fix/memory-leak
```

### 2. Add to VS Code

```bash
# Add folder to current workspace
code --add /workspaces/feat-oauth
```

### 3. Setup Python Environment

```bash
# Navigate to worktree
cd /workspaces/feat-oauth

# Sync dependencies (creates local .venv)
uv sync --all-extras

# VS Code will prompt to select interpreter
# Choose: ./.venv/bin/python
```

### 4. Develop Your Feature

Each Claude Code instance in a worktree can:
- Create and edit files
- Run tests independently
- Make commits to its branch
- Use all development tools

### 5. Create Pull Request

```bash
# Push branch to remote
git push -u origin feat/oauth

# Create PR
gh pr create --title "feat: add OAuth authentication" \
  --body "Implementation of OAuth2 flow..."
```

### 6. Cleanup After Merge

```bash
# From main repository
git worktree remove /workspaces/feat-oauth

# The branch is automatically deleted locally
```

## Important Considerations

### Environment Variables

- `WORKSPACE_PATH` always points to main repository
- Each worktree has its own working directory
- Use relative paths or `pwd` for worktree-specific paths

### Python Interpreter

VS Code requires interpreter selection per worktree:
1. Click on any .py file in the worktree
2. Select interpreter when prompted
3. Choose `./.venv/bin/python` from the worktree
4. VS Code remembers this per folder

### Git Operations

All standard git commands work normally:
```bash
# In worktree directory
git status        # Shows worktree branch status
git add -A        # Stages worktree changes
git commit        # Commits to worktree branch
git push          # Pushes worktree branch
```

### Parallel Development

Multiple Claude Code instances can work simultaneously:
- No file conflicts between worktrees
- Independent git operations
- Separate Python environments
- Isolated test runs

## Common Commands Reference

```bash
# List all worktrees
git worktree list

# Create worktree with new branch
git worktree add /workspaces/feat-api -b feat/api

# Create worktree from existing remote branch
git worktree add /workspaces/fix-bug origin/fix/bug-123

# Remove worktree
git worktree remove /workspaces/feat-api

# Prune stale worktree references
git worktree prune

# Add folder to VS Code
code --add /workspaces/feat-api

# Setup Python environment
cd /workspaces/feat-api
uv sync --all-extras
```

## Troubleshooting

### Permission Denied Creating Worktree

If you get "Permission denied" errors, the devcontainer setup script should have fixed this. If not:
```bash
sudo chown $(whoami):$(whoami) /workspaces
```

### VS Code Python Interpreter Issues

If VS Code shows interpreter warnings:
1. Ensure you've run `uv sync` in the worktree
2. Manually select interpreter: Ctrl+Shift+P → "Python: Select Interpreter"
3. Choose the `.venv` from the current worktree

### Worktree Already Exists

If a worktree path already exists:
```bash
# Force remove and recreate
git worktree remove --force /workspaces/old-feature
git worktree add /workspaces/old-feature -b new-feature
```

## Best Practices

1. **One Feature Per Worktree**: Keep changes focused
2. **Descriptive Names**: Use clear, conventional branch names
3. **Clean Up**: Remove worktrees after PR merge
4. **Sync Dependencies**: Run `uv sync` in each new worktree
5. **Commit Often**: Regular commits in your worktree branch

## Example: Multi-Agent Development

Here's how three Claude Code instances might work in parallel:

**Agent 1: Feature Development**
```bash
cd /workspaces/feat-user-profiles
# Develops new user profile functionality
```

**Agent 2: Bug Fix**
```bash
cd /workspaces/fix-data-validation
# Fixes validation bug in data processor
```

**Agent 3: Documentation**
```bash
cd /workspaces/docs-api-guide
# Updates API documentation
```

All three can:
- Work simultaneously
- Run tests independently  
- Make commits without conflicts
- See each other's work in VS Code explorer
- Create PRs when ready