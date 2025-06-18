# Devcontainer Setup

## Overview

The project uses two devcontainer profiles optimized for different environments:
- **Local development**: `.devcontainer/local/devcontainer.json`
- **GitHub Codespaces**: `.devcontainer/codespaces/devcontainer.json`

Both profiles use the `mcr.microsoft.com/devcontainers/universal:2` base image.

## Environment Detection

The environment is automatically detected:
- Local: `CODESPACES` environment variable is unset
- Codespaces: `CODESPACES` environment variable is set

## Devcontainer Features

The devcontainers use modular features for specific functionality:

```json
"features": {
  "ghcr.io/joernstoehler/claude-code-devcontainer-features/claude-code:1": {},
  "ghcr.io/joernstoehler/claude-code-devcontainer-features/claude-code-telemetry:1": {},
  "ghcr.io/joernstoehler/claude-code-devcontainer-features/claude-code-common-cli-tools:1": {},
  "ghcr.io/joernstoehler/claude-code-devcontainer-features/claude-code-shared-templates-git-remote:1": {
    "templateUrl": "https://github.com/JoernStoehler/claude-code-shared-templates.git"
  }
}
```

### Feature Descriptions

- **claude-code**: Installs Claude Code CLI and sets up configuration directory
- **claude-code-telemetry**: Configures OpenTelemetry for Claude Code telemetry  
- **claude-code-common-cli-tools**: Installs development tools (ripgrep, fd, bat, etc.)
- **claude-code-shared-templates-git-remote**: Sets up template repository as git remote for synchronization

## Post-Create Setup

Both profiles run scripts from `.devcontainer/postCreateCommand/` in numerical order:
- Environment configuration
- Project dependency installation
- Git submodule initialization
- Setup summary display

## VS Code Extensions

Both profiles include essential extensions:
- Claude Code integration
- Python development tools
- Git and GitHub integration
- General productivity tools

## Important Paths

- Working directory: `/workspaces/{branch-name-slug}` (for git worktrees)
- Main repository: `/workspaces/{repo-name}`
- Claude config: `$CLAUDE_CONFIG_DIR` (persisted across rebuilds)
- Python environment: `/home/codespace/.venv`