# Claude Code Development Guidelines

This is the entry point for Claude Code. This file is automatically read at the start of each session.

## Quick Start

You are working in a pre-configured development environment:
- Current directory: Either `/workspaces/your-project-name` (main) or `/workspaces/{branch-name}` (git worktree)
- Python environment: Active with `uv run`
- Tools available: `rg`, `fd`, `jq`, `gh`, `git`, `make`, `claude`
- Setup: Script-based configuration in `.devcontainer/postCreateCommand/`

Note: Small changes (docs, configs) can be done directly on main. Use worktrees for features/fixes.

## Essential Documentation

### 📁 Environment Setup
- @docs/claude/environment/00-overview.md - Environment overview
- @docs/claude/environment/01-devcontainer-setup.md - Devcontainer configuration
- @docs/claude/environment/02-secrets-and-config.md - Secrets and environment variables

### 🏗️ Development
- @docs/claude/development/00-principles.md - Core development principles
- @docs/claude/development/01-code-style.md - Code style and architecture
- @docs/claude/development/02-testing.md - Testing guidelines

### 🔄 Workflows  
- @docs/claude/workflows/00-task-management.md - Task management and templates
- @docs/claude/workflows/01-template-sync.md - Template synchronization
- @docs/claude/workflows/02-pull-requests.md - Pull request workflows
- @docs/claude/workflows/03-worktree-development.md - Git worktree parallel development
- @docs/claude/workflows/04-template-sync-troubleshooting.md - Template sync troubleshooting

### 📝 Standards
- @docs/claude/style/00-coding-standards.md - Language-specific standards
- @docs/claude/style/01-documentation.md - Documentation guidelines

## Project Context

- @docs/roadmap.md - Current project status and milestones
- @docs/changelog.md - Recent changes and version history
- @docs/tasks/ - Task-specific documentation and handoffs

## Key Reminders

### Working with Jörn
- Direct communication preferred (Crocker's Rules apply)
- Submit PRs for review via `gh pr create`
- Ask for clarification when needed
- [IMPORTANT] marks critical information

### Common Commands
```bash
# Testing and quality
uv run pytest                  # Run tests
uv run ruff check .           # Check linting
uv run pyright .              # Type checking

# Git workflow  
git status                    # Check changes
git diff                      # Review changes
git add <files>               # Stage specific files
git commit -m "type: message" # Conventional commit
gh pr create                  # Create pull request

# Git worktrees (parallel development)
git worktree add /workspaces/feat-name -b feat/name
code --add /workspaces/feat-name  # Add to VS Code
cd /workspaces/feat-name && uv sync --all-extras

# Development
make install                  # Install dependencies
make test                     # Run test suite
make dev                      # Start dev server
```

### Tool-Specific Notes
- You can use `cd` commands to navigate directories
- Environment variables are isolated per Bash() call
- Use parallel Read() calls without waiting for efficiency
- Task() agents can pre-filter/summarize large searches
- Prefer `mcp__tavily__tavily-search` over WebSearch()

### Environment Setup
- `.env` file auto-loads in local devcontainers
- GitHub secrets used in Codespaces
- `WORKSPACE_PATH` provides reliable workspace directory access
- Claude config persisted in `$WORKSPACE_PATH/.claude-config`
- Telemetry configured if Honeycomb credentials provided

## Getting Started with a Task

1. Read the task description carefully
2. Check relevant documentation above
3. Use the appropriate workflow template from @docs/claude/workflows/00-task-management.md
4. Create a Todo list to track progress
5. Begin implementation following our principles

Remember: You have access to 200K tokens of context. Use verbosity when it improves clarity.