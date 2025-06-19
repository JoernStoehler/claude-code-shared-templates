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

## Post-Create Scripts

The devcontainers use a modular script-based approach for setup. Scripts are stored in `.devcontainer/postCreateCommand/` and run in numerical order based on their filename prefix.

### Script Naming Convention

Scripts follow the pattern: `{number}-{descriptive-name}.sh`
- `10-install-system-dependencies-and-python-environment.sh` - Installs system packages, uv, Quarto, and Python dependencies
- Additional scripts can be added following this pattern

### Script Execution

The `postCreateCommand` in both devcontainer profiles runs:
```bash
for script in .devcontainer/postCreateCommand/*.sh; do 
  echo "Running $script..."
  bash "$script" || exit 1
done
```

This ensures:
- Scripts run in alphabetical/numerical order
- Each script's execution is logged
- Any script failure stops the setup process
- Easy addition of new setup steps

## Current Setup Scripts

1. **00-bashrc-store-workspace-path.sh**:
   - Sets `WORKSPACE_PATH` environment variable
   - Ensures reliable workspace path access for all scripts
   - Persists the variable in ~/.bashrc

2. **01-bashrc-loads-env-file.sh**:
   - Configures automatic .env file loading
   - Uses `WORKSPACE_PATH` for consistent file access

3. **02-bashrc-setups-claude-code-telemetry.sh**:
   - Optional telemetry configuration
   - Requires Honeycomb credentials

4. **03-bashrc-setups-claude-code-config-dir-in-workspace.sh**:
   - Sets Claude config directory in workspace
   - Ensures persistence across container rebuilds

5. **04-install-claude-code.sh**:
   - Installs Claude Code CLI via npm

6. **05-install-claude-code-common-tools.sh**:
   - Installs development tools (ripgrep, fd, bat, etc.)

7. **06-install-uv.sh**:
   - Installs uv Python package manager

8. **10-install-system-dependencies-and-python-environment.sh**:
   - Updates package lists
   - Installs system dependencies (cairo, pango, ffmpeg)
   - Installs Quarto for document processing
   - Syncs Python dependencies with uv

## VS Code Extensions

Both profiles include essential extensions:
- Claude Code integration
- Python development tools
- Git and GitHub integration
- General productivity tools

## Important Paths

- Working directory: `/workspaces/{branch-name-slug}` (for git worktrees)
- Main repository: `/workspaces/{repo-name}`
- Workspace path: `$WORKSPACE_PATH` (set by setup scripts)
- Claude config: `$CLAUDE_CONFIG_DIR` = `$WORKSPACE_PATH/.claude-config`
- Python environment: Managed by uv in workspace

### Adding New Setup Scripts

To add new setup functionality:
1. Create a new script in `.devcontainer/postCreateCommand/`
2. Name it with a number prefix (e.g., `20-configure-git.sh`)
3. Make sure it's executable: `chmod +x script-name.sh`
4. The script will automatically run during container creation