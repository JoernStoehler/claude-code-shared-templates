# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Devcontainer features for modular setup:
  - `claude-code` - Installs Claude CLI and sets configuration directory
  - `claude-code-telemetry` - Configures OpenTelemetry for telemetry (optional)
  - `claude-code-common-cli-tools` - Installs development tools and git configuration
  - `claude-code-shared-templates-git-remote` - Sets up template repository as git remote
- GitHub Actions workflows for feature testing and publishing
- Modular documentation structure in `docs/claude/`:
  - Environment setup documentation
  - Development principles and practices
  - Workflow guides (task management, template sync, PRs)
  - Coding and documentation standards
- Template synchronization workflow documentation
- Scripts subdirectory organization (ps-monitor, mcp-servers)
- Feature test suites

### Changed
- Restructured CLAUDE.md as concise entry point with links to detailed docs
- Updated devcontainer.json files to use new features
- Moved ps-monitor.py to scripts/ps-monitor/ps-monitor.py
- Simplified postCreateCommand scripts (functionality moved to features)
- Environment variable setup now split between features and project-specific

### Deprecated
- Direct functionality in postCreateCommand scripts 20 and 25 (moved to features)

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