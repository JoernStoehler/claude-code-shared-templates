# Environment Overview

This directory contains documentation about the development environment setup and configuration for Claude Code.

## Key Documents

- @docs/claude/environment/01-devcontainer-setup.md - Devcontainer profiles and configuration
- @docs/claude/environment/02-secrets-and-config.md - Environment variables and secrets management

## Quick Reference

The development environment is pre-configured with:
- Devcontainer support for both local and GitHub Codespaces
- Claude Code CLI and development tools
- Git worktrees for branch-based development
- Python environment with uv package manager
- Comprehensive linting and testing setup

## Environment Variables

Key environment variables set up automatically:
- `CODESPACES` - Set when running in GitHub Codespaces
- `CLAUDE_CONFIG_DIR` - Claude Code configuration directory
- `UV_PROJECT_ENVIRONMENT` - Python virtual environment location
- `DEVCONTAINER` - Indicates running in a devcontainer

For more details, see the specific documentation files in this directory.