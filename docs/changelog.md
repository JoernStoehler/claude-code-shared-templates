# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Script-based devcontainer setup in `.devcontainer/postCreateCommand/`:
  - `01-bashrc-loads-env-file.sh` - Automatic .env file loading for local development
  - `02-bashrc-setups-claude-code-telemetry.sh` - Optional telemetry configuration
  - `03-bashrc-setups-claude-code-config-dir-in-workspace.sh` - Persistent Claude config
  - `04-install-claude-code.sh` - Claude Code CLI installation
  - `05-install-claude-code-common-tools.sh` - Development tools (rg, fd, jq)
  - `06-install-uv.sh` - uv package manager installation
  - `07-fix-workspaces-permissions.sh` - Fix permissions for git worktree creation
  - `08-add-template-remote.sh` - Automatic template repository remote setup
  - `10-install-system-dependencies-and-python-environment.sh` - System deps and Python
- Consistent script header documentation format
- Numbered script execution system for predictable setup order
- CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1 to ensure consistent working directory
- Automatic template repository remote configuration for cherry-picking useful files

### Changed
- Migrated from devcontainer features to script-based setup
- Updated `postCreateCommand` to run all scripts in `.devcontainer/postCreateCommand/` sequentially
- Moved `setup-dependencies.sh` to `10-install-system-dependencies-and-python-environment.sh`
- Updated documentation to reflect script-based approach
- Template sync now automated via `08-add-template-remote.sh` script
- WORKSPACE_PATH now set via containerEnv in devcontainer.json using ${containerWorkspaceFolder}
- Reduced development tools to essentials only (removed bat, eza, httpie, tldr)

### Fixed
- Scripts in postCreateCommand now have access to WORKSPACE_PATH environment variable
- Fixed issue where bash subprocesses couldn't access exported variables from previous scripts

### Removed
- Devcontainer features dependency (broken feature removed)
- `setup-dependencies.sh` from root `.devcontainer/` directory
- `00-bashrc-store-workspace-path.sh` - No longer needed with containerEnv approach

### Previous Release Features

#### Devcontainer Features (Now Replaced)
- ~~Devcontainer features for modular setup~~ (replaced with scripts)
- GitHub Actions workflows for feature testing and publishing
- Modular documentation structure in `docs/claude/`:
  - Environment setup documentation
  - Development principles and practices
  - Workflow guides (task management, template sync, PRs)
  - Coding and documentation standards
- Template synchronization workflow documentation
- Scripts subdirectory organization (ps-monitor, mcp-servers)
- Feature test suites

#### Documentation Updates
- Restructured CLAUDE.md as concise entry point with links to detailed docs
- ~~Updated devcontainer.json files to use new features~~ (now uses scripts)
- Moved ps-monitor.py to scripts/ps-monitor/ps-monitor.py
- ~~Simplified postCreateCommand scripts~~ (now modularized in subdirectory)
- Environment variable setup now handled by individual scripts

### Infrastructure
- Initial template project setup
- Dual devcontainer configuration for local and codespaces development
- Comprehensive CLAUDE.md documentation with development guidelines
- Python project structure with uv dependency management
- Testing framework with pytest
- Type checking with pyright
- Linting with ruff
- Git workflows and conventional commits
- CI/CD pipeline configuration (GitHub Actions)
- Example module structure with tests
- Project documentation (roadmap, changelog)
- Python project configuration (pyproject.toml)
- Makefile with standard development commands
- Pre-commit hooks configuration
- Git LFS configuration (.gitattributes)
- Environment variable consistency (.env for local development)

### Infrastructure
- `.devcontainer/local/devcontainer.json` for local development
- `.devcontainer/codespaces/devcontainer.json` for GitHub Codespaces
- Post-create scripts for environment setup
- Environment variable management (.env for local, GitHub secrets for codespaces)

### Development Tools
- uv for dependency management
- ruff for linting (minimal rules to avoid interruptions)
- pyright for type checking (standard mode)
- pytest with coverage reporting
- pre-commit hooks
- gh CLI for GitHub operations

### Project Principles Established
- Test-driven development approach
- Pure functions with immutable data structures
- Pydantic models for data validation
- Google-style docstrings
- Mathematical notation support
- Optimize for ultra-fast exploration and onboarding

## [0.1.0] - TBD

*Initial release pending*