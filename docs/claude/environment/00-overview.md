# Environment Overview

This directory contains documentation about the development environment setup and configuration for Claude Code.

## Key Documents

- @docs/claude/environment/01-devcontainer-setup.md - Devcontainer profiles and configuration
- @docs/claude/environment/02-secrets-and-config.md - Environment variables and secrets management

## Quick Reference

The development environment is pre-configured with:
- Devcontainer support for both local and GitHub Codespaces
- Script-based setup in `.devcontainer/postCreateCommand/`
- Claude Code CLI and development tools
- Git worktrees for branch-based development
- Python environment with uv package manager
- Comprehensive linting and testing setup

## Setup Scripts

The environment setup is handled by numbered scripts that run in order:
1. **01-bashrc-loads-env-file.sh** - Configures .env file loading
2. **02-bashrc-setups-claude-code-telemetry.sh** - Sets up telemetry (optional)
3. **03-bashrc-setups-claude-code-config-dir-in-workspace.sh** - Persistent config
4. **04-install-claude-code.sh** - Installs Claude Code CLI
5. **05-install-claude-code-common-tools.sh** - Development tools
6. **06-install-uv.sh** - Python package manager
7. **07-fix-workspaces-permissions.sh** - Fix permissions for git worktrees
8. **10-install-system-dependencies-and-python-environment.sh** - System deps & Python

## Environment Variables

Key environment variables set up automatically:
- `WORKSPACE_PATH` - Reliable path to workspace directory (set by containerEnv in devcontainer.json)
- `CLAUDE_TEMPLATE_REPO_URL` - Template repository URL for easy cloning
- `CODESPACES` - Set when running in GitHub Codespaces
- `CLAUDE_CONFIG_DIR` - Claude Code configuration directory (persisted in workspace)

### Telemetry Variables (Optional)
If configured with Honeycomb credentials:
- `CLAUDE_CODE_ENABLE_TELEMETRY` - Enables telemetry
- `OTEL_*` - OpenTelemetry configuration

For more details, see the specific documentation files in this directory.