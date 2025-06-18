# Claude Code Shared Templates

A comprehensive project template for Claude Code development, featuring modern Python tooling, devcontainer support, and best practices documentation.

## Quick Start

### Use as a Template

1. Click "Use this template" on GitHub
2. Create a new repository
3. Open in VS Code with devcontainers or GitHub Codespaces
4. Start developing!

### Features

- **Pre-configured Development Environment**
  - Dual devcontainer profiles (local and Codespaces)
  - Claude Code CLI integration
  - Modern Python tooling (uv, ruff, pyright, pytest)
  - Essential development tools (ripgrep, fd, bat, etc.)

- **Template Synchronization**
  - Bidirectional sync between template and derived projects
  - Cherry-pick improvements back to template
  - Keep projects up-to-date with template enhancements

- **Comprehensive Documentation**
  - Claude Code principles and workflows
  - Task management templates
  - Coding standards and style guides
  - Environment setup guides

## Project Structure

```
├── .devcontainer/          # Devcontainer configurations
│   ├── local/             # Local development profile
│   └── codespaces/        # GitHub Codespaces profile
├── docs/                  # Documentation
│   └── claude/           # Claude Code specific docs
├── example/              # Example Python module
├── scripts/              # Utility scripts
│   └── ps-monitor/       # Process monitoring tool
├── tests/                # Test suite
├── CLAUDE.md            # Claude Code entry point
├── pyproject.toml       # Python project configuration
└── Makefile             # Development commands
```

## Devcontainer Features

This template uses modular devcontainer features from [claude-code-devcontainer-features](https://github.com/JoernStoehler/claude-code-devcontainer-features):

- **claude-code**: Installs Claude CLI and configuration
- **claude-code-telemetry**: OpenTelemetry setup (optional)
- **claude-code-common-cli-tools**: Development tools and git config
- **claude-code-shared-templates-git-remote**: Template sync setup

## Development Workflow

### Common Commands

```bash
# Install dependencies
make install

# Run tests
make test

# Type checking
make typecheck

# Linting
make lint

# Start development server
make dev
```

### Git Workflow

```bash
# Create feature branch
git checkout -b feat/new-feature

# Make changes and commit
git add -A
git commit -m "feat: add new feature"

# Create pull request
gh pr create
```

### Template Synchronization

```bash
# Fetch latest template updates
git fetch template

# Merge template changes
git merge template/main

# Cherry-pick specific improvements
git cherry-pick <commit-hash>
```

## Contributing

### To This Template

1. Fork this repository
2. Create a feature branch
3. Make your improvements
4. Submit a pull request

Good candidates for template contributions:
- Claude Code workflow improvements
- Devcontainer enhancements
- General utility scripts
- Documentation improvements

### From Derived Projects

When you've made improvements in your project that would benefit others:

```bash
# Create branch from template
git checkout -b template-improvement template/main

# Cherry-pick your improvements
git cherry-pick <your-commits>

# Push to your fork and create PR
```

## Documentation

Key documentation files:
- `CLAUDE.md` - Claude Code entry point
- `docs/claude/` - Comprehensive guides:
  - Development principles
  - Environment setup
  - Workflows (tasks, PRs, template sync)
  - Coding standards
  - Documentation standards

## License

MIT License - see LICENSE file for details.

## Maintainer

**Jörn Stöhler** - Project owner and primary maintainer

## Related Projects

- [claude-code-devcontainer-features](https://github.com/JoernStoehler/claude-code-devcontainer-features) - Devcontainer features used by this template
- [template-universal](https://github.com/JoernStoehler/template-universal) - Original monolithic template (deprecated)
